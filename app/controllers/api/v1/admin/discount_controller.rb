module Api
  module V1
    module Admin
      class DiscountController < ApplicationController
        skip_before_action :verify_authenticity_token
        before_action :set_discount, only: [:show, :update, :destroy]
        include Error::ErrorHandler

        def index
          @discounts = ::Discount.all
        end

        def show
        end

        def create
          result = Api::V1::Admin::Discount::Create.new.call(discount_params)
          return render json: { errors: result.failure[:errors] },status: 400 if result.failure?

          @discount = result.value![:discount].attributes
          render :show
        end

        def update
          result = Api::V1::Admin::Discount::Update.new.call(discount_params.merge(discount: @discount))
          return render json: { errors: result.failure[:errors] },status: 400 if result.failure?

          @discount = result.value![:discount].attributes
          render :show
        end

        def destroy
          @discount.destroy!
          render json: { message: 'Discount successfully destroyed.' }
        end

        private

        def set_discount
          @discount = ::Discount.find(params[:id])
        end

        def discount_params
          params.require(:discount).permit(:title, :percent, :expired, :meta, :description, :start_date, :end_date)
        end
      end
    end
  end
end
