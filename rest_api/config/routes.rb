Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  get "/policies/:policy_id", to: "policies#show"
  get "/", to: "policies#index"
  # Defines the root path route ("/")
  # root "articles#index"
end
