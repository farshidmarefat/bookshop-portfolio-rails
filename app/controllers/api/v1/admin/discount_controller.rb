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
          start_date = parse_date(params[:start_date])
          end_date = parse_date(params[:end_date])

          @discount = ::Discount.create(discount_params.merge(start_date: start_date, end_date: end_date))
          render :show
        end

        def update
          @discount.update!(discount_params)
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
          params.permit(:title, :percent, :expired, :meta, :description)
        end
      end
    end
  end
end
