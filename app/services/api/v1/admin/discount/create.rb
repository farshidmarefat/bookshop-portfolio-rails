module Api
  module V1
    module Admin
      module Discount
        class Create < BaseDiscount
          include Dry::Transaction

          step :validate_params
          step :create_discount

          private

          def validate_params(input)
            common_validations(input)
          end

          def create_discount(discount_params)
            @discount = ::Discount.new(discount_params)

            if @discount.save
              Success(discount: @discount)
            else
              Failure(errors: @discount.errors.full_messages)
            end
          end
        end
      end
    end
  end
end
