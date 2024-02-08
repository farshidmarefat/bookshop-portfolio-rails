class Cart < ApplicationRecord
  belongs_to :user
  belongs_to :cart_delivery
  has_many :cart_items
end
