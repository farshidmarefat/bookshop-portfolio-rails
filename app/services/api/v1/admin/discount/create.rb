module Api
  module V1
    module Admin
      module Discount
        class Create
          include Dry::Transaction

          step :validate_params
          step :create_discount

          private

          def validate_params(input)
            title = input[:title]
            percent = input[:percent]
            start_date = input[:start_date]
            end_date = input[:end_date]
            expired = input[:expired]

            # Check if title is present and within 255 characters limit
            if title.blank? || title.length > 255
              return Failure(errors: 'Title is missing or exceeds 255 characters limit')
            end

            # Check if percent is within 0-100 range
            if percent.blank? || percent.to_i < 0 || percent.to_i > 100
              return Failure(errors: 'Percent must be between 0 and 100')
            end

            # Check if start_date and end_date are present and in valid format (DD/MM/YYYY)
            date_format = /\A\d{2}\/\d{2}\/\d{4}\z/
            unless start_date.match?(date_format)
              return Failure(errors: 'Invalid start date format. Date format should be DD/MM/YYYY')
            end

            unless end_date.match?(date_format)
              return Failure(errors: 'Invalid end date format. Date format should be DD/MM/YYYY')
            end

            # Check if start_date is after the current date
            if Date.strptime(start_date, '%d/%m/%Y') < Date.today
              return Failure(errors: 'Start date must not be before the current date')
            end

            # Check if end_date is after start_date
            if Date.strptime(start_date, '%d/%m/%Y') >= Date.strptime(end_date, '%d/%m/%Y')
              return Failure(errors: 'End date must be after start date')
            end

            # Check if expired is present
            if expired.nil?
              return Failure(errors: 'Expired field is missing')
            end

            Success(input)
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
