Rails.application.routes.draw do
  
  get 'sessions/new'
  root 'homes#main'
  resources :users
  get "/signup", to: 'users#new'
end
