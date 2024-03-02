Rails.application.routes.draw do
  get "up" => "rails/health#show", as: :rails_health_check

  namespace :api do
    namespace :v1 do
      resources :app_meta
      namespace :admin do

      end
      namespace :customer do

      end
    end
  end

end
