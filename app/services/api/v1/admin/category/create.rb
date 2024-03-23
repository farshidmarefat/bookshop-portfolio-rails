module Api
  module V1
    module Admin
      module Category
        class Create < BaseCategory
          include Dry::Transaction

          step :validate_params
          step :process_icon
          step :create_category

          private

          def validate_params(input)
            category_validations(input)
          end

          def create_category(category_params)
            @category = ::Category.new(category_params)

            if @category.save
              Success(category: @category)
            else
              Failure(errors: @category.errors.full_messages)
            end
          end
        end
      end
    end
  end
end