Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  get "/policies/:id", to: "policies#show"
  get "/", to: "policies#index"
  resources :insureds, only: %i[index show]
  resources :vehicles, only: %i[index show]
  post "/webhooks" => "webhooks#update"
end
