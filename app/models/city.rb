class City < ApplicationRecord
  belongs_to :province
  has_many :user_addresses
end
