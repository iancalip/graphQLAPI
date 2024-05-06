Rails.application.routes.draw do
  root "policies#index"
  devise_for :users, controllers: {
    registrations: "users/registrations",
    sessions: "users/sessions",
    omniauth_callbacks: "users/omniauth_callbacks"
  }
  resources :policies

  resources :payments, only: [:new, :create]
  get "payments/success"
  get "payments/cancel"
end
