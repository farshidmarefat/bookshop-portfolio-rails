class Product < ApplicationRecord
  belongs_to :category
  belongs_to :author
  belongs_to :translator
  belongs_to :publisher
  belongs_to :discount
end
