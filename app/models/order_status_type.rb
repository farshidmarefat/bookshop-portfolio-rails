class OrderStatusType < ApplicationRecord
  has_many :user_orders
end
