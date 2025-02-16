class SessionsController < Devise::SessionsController
  skip_before_action :verify_authenticity_token
  def create
    user = User.find_by_email(params[:email])

    if user && user.valid_password?(params[:password])
      token = user.generate_jwt
      render json: token.to_json
    else
      render json: { errors: { 'email or password' => ['is invalid'] } }, status: :unprocessable_entity
    end
  end
end