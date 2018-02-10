Rails.application.routes.draw do
  root 'welcomes#index'
  resources :users
  resources :sessions
  delete '/logout'=> 'sessions#destroy', as: :logout
  resources :cellphone_tokens
end
