Rails.application.routes.draw do
  
  root 'homes#main'

  # Users
  resources :users, except: :new
  get "/signup", to: 'users#new'

  # Sessions
  get "/login", to: "sessions#new"
  post "/login", to: "sessions#create"
  delete "/logout", to: "sessions#destroy"
end
