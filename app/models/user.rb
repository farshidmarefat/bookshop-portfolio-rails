class User < ApplicationRecord
  has_many :user_addresses
  has_many :user_orders
  has_many :user_permissions
  has_many :user_favorites
  has_many :user_logs
end
