module Api
  module V1
    class AppMetaController < ApplicationController
      skip_before_action :verify_authenticity_token
      before_action :set_app_meta, only: [:show, :update, :destroy]
      include Error::ErrorHandler

      def index
        @app_metum = AppMetum.all
      end

      def show
      end

      def create
        @app_meta = ::AppMetum.create(app_meta_params)
        render :show
      end

      def update
        @app_meta.update!(app_meta_params)
        render :show
      end

      def destroy
        @app_meta.destroy!
        render json: { message: 'AppMeta successfully destroyed.' }
      end

      private

      def set_app_meta
        @app_meta = ::AppMetum.find(params[:id])
      end

      def app_meta_params
        params.require(:app_metum).permit(:shop_name, :first_phone, :second_phone, :instagram, :telegram, :whatsapp, :facebook, :linkedin, :twitter, :youtube, :aparat, :email, :address, :latitude, :longitude, :terms, :about_us, :meta, :description)
      end
    end
  end
end
