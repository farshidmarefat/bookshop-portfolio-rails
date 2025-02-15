Rails.application.routes.draw do
  get "up" => "rails/health#show", as: :rails_health_check

  namespace :api do
    namespace :v1 do
      resources :app_meta

      devise_for :users, controllers: {
        sessions: "api/v1/users/sessions",
        registrations: "api/v1/users/registrations",
        passwords: "api/v1/users/passwords"
      }

      namespace :admin do
        resources :discount
        resources :category
        resources :author
        resources :translator
        resources :publisher
      end

      namespace :customer do

      end
    end
  end

end
