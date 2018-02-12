Rails.application.routes.draw do
  mount API::Base, at: '/api'
  mount GrapeSwaggerRails::Engine => '/api/doc'
  root 'welcomes#index'
  resources :users
  resources :sessions
  delete '/logout'=> 'sessions#destroy', as: :logout
  resources :cellphone_tokens

  namespace :admin do
    root 'welcomes#index'
    resources :sessions
    delete '/logout'=> 'sessions#destroy', as: :logout
  end
end
