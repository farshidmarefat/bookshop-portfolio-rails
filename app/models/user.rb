class User < ApplicationRecord
  has_many :user_addresses
  has_many :user_orders
  has_many :user_permissions
  has_many :user_favorites
  has_many :user_logs
  # Include default devise modules. Others available are:
  # :confirmable, :recoverable, :rememberable, :validatable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable

  def generate_jwt
    JWT.encode({id: id, exp: 60.days.from_now.to_i}, ENV['DEVISE_JWT_SECRET_KEY'])
  end

  private

  def set_jti
    self.jti ||= SecureRandom.uuid
  end
end
