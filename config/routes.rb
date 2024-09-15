Rails.application.routes.draw do
  mount Rswag::Ui::Engine => "/api-docs"
  mount Rswag::Api::Engine => "/api-docs"
  get "up" => "rails/health#show", as: :rails_health_check

  resources :transactions

  post "/login", to: "auth#login"
  post "/register", to: "auth#register"
end
