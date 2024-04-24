Rails.application.routes.draw do
  root "policies#index"
  devise_for :users, controllers: {
    registrations: "users/registrations",
    sessions: "users/sessions",
    omniauth_callbacks: "users/omniauth_callbacks"
  }

  resources :payments, only: [:new, :update, :show] do
    collection do
      post "create"
      get "success", to: "payments#success", as: :payments_success
      get "cancel", to: "payments#cancel", as: :payments_cancel
    end
  end
end
