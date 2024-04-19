Rails.application.routes.draw do
  root "policies#index"
  devise_for :users, controllers: {
    registrations: "users/registrations",
    sessions: "users/sessions",
    omniauth_callbacks: "users/omniauth_callbacks"
  }

  resources :payments, only: [:new, :show] do
    collection do
      post "create"
      get "success"
      get "cancel"
    end
  end
end
