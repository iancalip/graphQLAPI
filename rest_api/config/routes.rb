Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  resources :policies, only: [:show, :index]
  get "/", to: "policies#index"
  # Defines the root path route ("/")
  # root "articles#index"
end
