Rails.application.routes.draw do
  get "registrations/create"
  get "sessions/create"
  mount Rswag::Ui::Engine => "/api-docs"
  mount Rswag::Api::Engine => "/api-docs"
  get "up" => "rails/health#show", as: :rails_health_check

  resources :transactions

  post "/login", to: "sessions#create"
  post "/register", to: "registration#create"
end
