module Api
  module V1
    module Admin
      module Discount
        class BaseDiscount
          include Dry::Transaction

          private

          def create_discount_validations(input)
            title = input[:title]
            percent = input[:percent]
            start_date = input[:start_date]
            end_date = input[:end_date]
            expired = input[:expired]

            # Check if title is present and within 255 characters limit
            if title.blank?
              return Failure(errors: 'Title is missing')
            end

            if title.length > 255
              return Failure(errors: 'Title exceeds 255 characters limit')
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

          def update_discount_validations(input)
            title = input[:title]
            percent = input[:percent]
            start_date = input[:start_date]
            end_date = input[:end_date]
            expired = input[:expired]

            # Check if title is present and within 255 characters limit
            if title.present?
              return Failure(errors: 'Title is missing') if title.blank?
              return Failure(errors: 'Title exceeds 255 characters limit') if title.length > 255
            end

            # Check if percent is within 0-100 range
            if percent.present?
              return Failure(errors: 'Percent is missing') if percent.blank?
              return Failure(errors: 'Percent must be between 0 and 100') if percent.to_i < 0 || percent.to_i > 100
            end

            date_format = /\A\d{2}\/\d{2}\/\d{4}\z/
            # Check if start_date and end_date are present and in valid format (DD/MM/YYYY)
            if start_date.present?
              return Failure(errors: 'Invalid start date format. Date format should be DD/MM/YYYY') unless start_date.match?(date_format)
              # Check if start_date is after the current date
              return Failure(errors: 'Start date must not be before the current date') if Date.strptime(start_date, '%d/%m/%Y') < Date.today
              # Check if start_date is after end_date
              return Failure(errors: 'Start date can not be after end date') if Date.strptime(start_date, '%d/%m/%Y') >= input[:discount]&.end_date
            end

            if end_date.present?
              return Failure(errors: 'Invalid end date format. Date format should be DD/MM/YYYY') unless end_date.match?(date_format)
              # Check if end_date is before start_date
              return Failure(errors: 'End date can not be before start date') if Date.strptime(end_date, '%d/%m/%Y') < input[:discount]&.start_date
            end

            # Check if expired is present
            if expired.present?
              return Failure(errors: 'Expired field is missing') if expired.nil?
            end

            Success(input)
          end
        end
      end
    end
  end
end
