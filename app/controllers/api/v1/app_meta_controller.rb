module Api
  module V1
    class AppMetaController < ApplicationController
      before_action :set_app_meta, only: [:show, :edit, :update, :destroy]

      def index
        @app_metum = AppMetum.all
      end

      def show
      end

      def new
        @app_metum = AppMetum.new
      end

      def create
        @app_metum = AppMetum.new(app_meta_params)
        if @app_metum.save
          redirect_to @app_metum, notice: 'AppMeta was successfully created.'
        else
          render :new
        end
      end

      def edit
      end

      def update
        if @app_metum.update(app_meta_params)
          redirect_to @app_metum, notice: 'AppMeta was successfully updated.'
        else
          render :edit
        end
      end

      def destroy
        @app_metum.destroy
        redirect_to app_meta_url, notice: 'AppMeta was successfully destroyed.'
      end

      private

      def set_app_meta
        @app_metum = AppMetum.find(params[:id])
      end

      def app_meta_params
        params.require(:app_meta).permit(:shop_name, :first_phone, :second_phone, :instagram, :telegram, :whatsapp, :facebook, :linkedin, :twitter, :youtube, :aparat, :email, :address, :latitude, :longitude, :terms, :about_us, :meta, :description)
      end
    end
  end
end
