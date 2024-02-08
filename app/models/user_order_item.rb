class UserOrderItem < ApplicationRecord
  belongs_to :user_order
  belongs_to :product
end
