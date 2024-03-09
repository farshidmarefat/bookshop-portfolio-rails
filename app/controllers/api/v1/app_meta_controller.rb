module Api
  module V1
    class AppMetaController < ApplicationController
      skip_before_action :verify_authenticity_token
      before_action :set_app_meta, only: [:show, :update, :destroy]

      def index
        @app_metum = AppMetum.all
      end

      def show
      end

      def new
        @app_metum = AppMetum.new
      end

      def create
        @app_metum = ::AppMetum.create(app_meta_params)
        render :show
      end

      def update
        @app_metum.update_attributes(app_meta_params)
        render :show
      end

      def destroy
        @app_metum.destroy!
      end

      private

      def set_app_meta
        @app_metum = ::AppMetum.find(params[:id])
      end

      def app_meta_params
        params.permit(:shop_name, :first_phone, :second_phone, :instagram, :telegram, :whatsapp, :facebook, :linkedin, :twitter, :youtube, :aparat, :email, :address, :latitude, :longitude, :terms, :about_us, :meta, :description)
      end
    end
  end
end
