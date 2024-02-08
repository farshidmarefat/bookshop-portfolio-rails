class UserAddress < ApplicationRecord
  belongs_to :user
  belongs_to :province
  belongs_to :city
  has_many :cart_deliveries
end
