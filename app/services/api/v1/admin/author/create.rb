module Api
  module V1
    module Admin
      module Author
        class Create < BaseAuthor
          include Dry::Transaction

          step :validate_params
          step :process_avatar
          step :create_author

          private

          def validate_params(input)
            create_author_validations(input)
          end

          def create_author(author_params)
            @author = ::Author.new(author_params)

            if @author.save
              Success(author: @author)
            else
              Failure(errors: @author.errors.full_messages)
            end
          end
        end
      end
    end
  end
end
