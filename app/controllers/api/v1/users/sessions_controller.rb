module Api
  module V1
    module Users
      class SessionsController < Devise::SessionsController
        respond_to :json
        skip_before_action :verify_authenticity_token

        def create
          user = User.find_by(email: params[:user][:email])

          if user.nil?
            render json: { error: "User not found" }, status: :unauthorized
          elsif !user.valid_password?(params[:user][:password])
            render json: { error: "Invalid password" }, status: :unauthorized
          else
            token = Warden::JWTAuth::UserEncoder.new.call(user, :user, nil).first
            render json: { user: user, token: token }, status: :ok
          end
        end
      end
    end
  end
end
