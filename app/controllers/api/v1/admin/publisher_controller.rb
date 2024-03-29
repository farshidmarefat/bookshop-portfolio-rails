module Api
  module V1
    module Admin
      class PublisherController < ApplicationController
        skip_before_action :verify_authenticity_token
        before_action :set_publisher, only: [:show, :update, :destroy]
        include Error::ErrorHandler

        def index
          @publishers = ::Publisher.all
        end

        def show
        end

        def create
          result = Api::V1::Admin::Publisher::Create.new.call(publisher_params)
          return render json: { errors: result.failure[:errors] }, status: 400 if result.failure?

          @publisher = result.value![:publisher].attributes
          render :show
        end

        def update
          result = Api::V1::Admin::Publisher::Update.new.call(publisher_params.merge(publisher: @publisher))
          return render json: { errors: result.failure[:errors] }, status: 400 if result.failure?

          @publisher = result.value![:publisher].attributes
          render :show
        end

        def destroy
          @publisher.destroy!
          render json: { message: 'Publisher successfully destroyed.' }
        end

        private

        def set_publisher
          @publisher = ::Publisher.find(params[:id])
        end

        def publisher_params
          params.require(:publisher).permit(:title, :logo, :slug, :meta, :description)
        end
      end
    end
  end
end