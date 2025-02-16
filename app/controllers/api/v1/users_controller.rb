module Api
  module V1
    class UsersController < ApplicationController
      before_action :authenticate_user!

      def show
        render json: current_user, except: [:password_digest]
      end
    end
  end
end
