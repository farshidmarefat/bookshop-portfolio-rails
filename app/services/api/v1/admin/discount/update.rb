module Api
  module V1
    module Admin
      module Discount
        class Update < BaseDiscount
          include Dry::Transaction

          step :validate_params
          step :update_discount

          private

          def validate_params(input)
            discount_validations(input)
          end

          def update_discount(input)
            discount = input[:discount]

            discount.assign_attributes(input.except(:id, :discount))

            if discount.save
              Success(discount: discount)
            else
              Failure(errors: discount.errors.full_messages)
            end
          end
        end
      end
    end
  end
end
