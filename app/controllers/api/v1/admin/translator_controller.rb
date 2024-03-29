module Api
  module V1
    module Admin
      class TranslatorController < ApplicationController
        skip_before_action :verify_authenticity_token
        before_action :set_translator, only: [:show, :update, :destroy]
        include Error::ErrorHandler

        def index
          @translators = ::Translator.all
        end

        def show
        end

        def create
          result = Api::V1::Admin::Translator::Create.new.call(translator_params)
          return render json: { errors: result.failure[:errors] }, status: 400 if result.failure?

          @translator = result.value![:translator].attributes
          render :show
        end

        def update
          result = Api::V1::Admin::Translator::Update.new.call(translator_params.merge(translator: @translator))
          return render json: { errors: result.failure[:errors] }, status: 400 if result.failure?

          @translator = result.value![:translator].attributes
          render :show
        end

        def destroy
          @translator.destroy!
          render json: { message: 'Translator successfully destroyed.' }
        end

        private

        def set_translator
          @translator = ::Translator.find(params[:id])
        end

        def translator_params
          params.require(:translator).permit(:full_name, :avatar, :meta, :description)
        end
      end
    end
  end
end