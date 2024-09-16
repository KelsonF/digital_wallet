Rails.application.routes.draw do
  mount Rswag::Ui::Engine => "/api-docs"
  mount Rswag::Api::Engine => "/api-docs"
  get "up" => "rails/health#show", as: :rails_health_check

  resources :transactions
  get "transactions/balance", to: "transactions#balance"

  post "/login", to: "sessions#create"
  post "/register", to: "registration#create"
end
