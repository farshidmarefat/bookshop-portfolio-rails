class UserOrder < ApplicationRecord
  belongs_to :user
  belongs_to :order_status_type
  has_many :user_order_items
end
