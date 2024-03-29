module Api
  module V1
    module Admin
      module Publisher
        class Update < BasePublisher
          include Dry::Transaction

          step :validate_params
          step :process_logo
          step :update_publisher

          private

          def validate_params(input)
            update_publisher_validations(input)
          end

          def process_logo(input)
            if input[:logo].present?
              uploaded_logo = input[:logo]
              input[:logo_url] = process_logo_upload(uploaded_logo, 'publisher')
            end

            Success(input)
          end

          def process_logo_upload(logo, model)
            uploader = LogoUploader.new(model)
            uploader.store!(logo)
            uploader.url
          end

          def update_publisher(input)
            publisher = input[:publisher]

            publisher.assign_attributes(input.except(:id, :publisher))

            if publisher.save
              Success(publisher: publisher)
            else
              Failure(errors: publisher.errors.full_messages)
            end
          end
        end
      end
    end
  end
end