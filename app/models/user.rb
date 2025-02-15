class User < ApplicationRecord
  has_many :user_addresses
  has_many :user_orders
  has_many :user_permissions
  has_many :user_favorites
  has_many :user_logs
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :jwt_authenticatable, jwt_revocation_strategy: JwtDenylist

  before_create :set_jti

  private

  def set_jti
    self.jti ||= SecureRandom.uuid
  end
end
