module Api
  module V1
    module Admin
      class AuthorController < ApplicationController
        skip_before_action :verify_authenticity_token
        before_action :set_author, only: [:show, :update, :destroy]
        include Error::ErrorHandler

        def index
          @authors = ::Author.all
        end

        def show
        end

        def create
          result = Api::V1::Admin::Author::Create.new.call(author_params)
          return render json: { errors: result.failure[:errors] }, status: 400 if result.failure?

          @author = result.value![:author].attributes
          render :show
        end

        def update
          result = Api::V1::Admin::Author::Update.new.call(author_params.merge(author: @author))
          return render json: { errors: result.failure[:errors] }, status: 400 if result.failure?

          @author = result.value![:author].attributes
          render :show
        end

        def destroy
          @author.destroy!
          render json: { message: 'Author successfully destroyed.' }
        end

        private

        def set_author
          @author = ::Author.find(params[:id])
        end

        def author_params
          params.require(:author).permit(:full_name, :avatar, :meta, :description)
        end
      end
    end
  end
end