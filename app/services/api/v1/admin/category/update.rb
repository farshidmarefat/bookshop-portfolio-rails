module Api
  module V1
    module Admin
      module Category
        class Update < BaseCategory
          include Dry::Transaction

          step :validate_params
          step :process_icon
          step :update_category

          private

          def validate_params(input)
            update_category_validations(input)
          end

          def process_icon(input)
            if input[:icon].present?
              uploaded_icon = input[:icon]
              input[:icon_url] = process_icon_upload(uploaded_icon, 'category')
            end

            Success(input)
          end

          def process_icon_upload(icon, model)
            uploader = IconUploader.new(model)
            uploader.store!(icon)
            uploader.url
          end

          def update_category(input)
            category = input[:category]

            category.assign_attributes(input.except(:id, :category))

            if category.save
              Success(category: category)
            else
              Failure(errors: category.errors.full_messages)
            end
          end
        end
      end
    end
  end
end