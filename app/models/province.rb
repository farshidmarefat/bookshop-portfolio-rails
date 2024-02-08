class Province < ApplicationRecord
  has_many :user_addresses
  has_many :cities
end
