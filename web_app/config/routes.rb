Rails.application.routes.draw do
  root "policies#index"
  devise_for :users, controllers: {
    registrations: "users/registrations",
    sessions: "users/sessions",
    omniauth_callbacks: "users/omniauth_callbacks"
  }
  resources :policies, only: [:new, :create, :show, :index]

  resources :payments, only: [:new, :create]
  get "payments/success"
  get "payments/cancel"

  mount ActionCable.server => "/cable"
  post "/live_confirm", to: "payments#live_confirm"
  post "/stripe/webhooks", to: "payments#receive"
end
