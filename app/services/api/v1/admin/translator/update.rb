module Api
  module V1
    module Admin
      module Translator
        class Update < BaseTranslator
          include Dry::Transaction

          step :validate_params
          step :process_avatar
          step :update_translator

          private

          def validate_params(input)
            update_translator_validations(input)
          end

          def process_avatar(input)
            if input[:avatar].present?
              uploaded_avatar = input[:avatar]
              input[:avatar_url] = process_avatar_upload(uploaded_avatar, 'translator')
            end

            Success(input)
          end

          def process_avatar_upload(avatar, model)
            uploader = AvatarUploader.new(model)
            uploader.store!(avatar)
            uploader.url
          end

          def update_translator(input)
            translator = input[:translator]

            translator.assign_attributes(input.except(:id, :translator))

            if translator.save
              Success(translator: translator)
            else
              Failure(errors: translator.errors.full_messages)
            end
          end
        end
      end
    end
  end
end