module Api
  module V1
    module Admin
      module Translator
        class BaseTranslator
          include Dry::Transaction

          private

          def create_translator_validations(input)
            full_name = input[:full_name]

            # Check if full_name is present and within 255 characters limit
            if full_name.blank?
              return Failure(errors: 'Full name is missing')
            end

            if full_name.length > 255
              return Failure(errors: 'Full name exceeds 255 characters limit')
            end

            Success(input)
          end

          def update_translator_validations(input)
            full_name = input[:full_name]

            # Check if full_name is present and within 255 characters limit
            if full_name.present?
              return Failure(errors: 'Full name is missing') if full_name.blank?
              return Failure(errors: 'Full name exceeds 255 characters limit') if full_name.length > 255
            end

            Success(input)
          end
        end
      end
    end
  end
end
