module Api
  module V1
    module Admin
      class CategoryController < ApplicationController
        skip_before_action :verify_authenticity_token
        before_action :set_category, only: [:show, :update, :destroy]
        include Error::ErrorHandler

        def index
          @categories = Category.all
        end

        def show
        end

        def create
          result = Api::V1::Admin::Category::Create.new.call(category_params)
          return render json: { errors: result.failure[:errors] }, status: 400 if result.failure?

          @category = result.value![:category].attributes
          render :show
        end

        def update
          result = Api::V1::Admin::Category::Update.new.call(category_params.merge(category: @category))
          return render json: { errors: result.failure[:errors] }, status: 400 if result.failure?

          @category = result.value![:category].attributes
          render :show
        end

        def destroy
          @category.destroy!
          render json: { message: 'Category successfully destroyed.' }
        end

        private

        def set_category
          @category = Category.find(params[:id])
        end

        def category_params
          params.require(:category).permit(:discount_id, :title, :icon_url, :slug, :meta, :description)
        end
      end
    end
  end
end