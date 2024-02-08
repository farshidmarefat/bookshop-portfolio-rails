class Category < ApplicationRecord
  belongs_to :discount
  has_many :products
end
