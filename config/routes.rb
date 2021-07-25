Rails.application.routes.draw do
  
  root 'homes#main'
  resources :users
  get "/signup", to: 'users#new'
end
