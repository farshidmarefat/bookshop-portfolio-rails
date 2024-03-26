module Api
  module V1
    module Admin
      module Author
        class Update < BaseAuthor
          include Dry::Transaction

          step :validate_params
          step :process_avatar
          step :update_author

          private

          def validate_params(input)
            update_author_validations(input)
          end

          def update_author(input)
            author = input[:author]

            author.assign_attributes(input.except(:id, :author))

            if author.save
              Success(author: author)
            else
              Failure(errors: author.errors.full_messages)
            end
          end
        end
      end
    end
  end
end