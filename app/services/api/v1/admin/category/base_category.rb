module Api
  module V1
    module Admin
      module Category
        class BaseCategory
          include Dry::Transaction

          private

          def category_validations(input)
            title = input[:title]
            slug = input[:slug]

            # Check if title is present and within 255 characters limit
            if title.blank?
              return Failure(errors: 'Title is missing')
            end

            if title.length > 255
              return Failure(errors: 'Title exceeds 255 characters limit')
            end

            # Check if slug is present and in valid format (slugs)
            unless slug.present? && slug.match?(/\A[\p{L}0-9]+(?:-[\p{L}0-9]+)*\z/)
              return Failure(errors: 'Slug is missing or invalid. It should be in the format of slugs')
            end

            # Check if slug is unique
            if ::Category.exists?(slug: slug)
              return Failure(errors: 'Slug must be unique')
            end

            Success(input)
          end
        end
      end
    end
  end
end