# frozen_string_literal: true

Rails.application.routes.draw do



  #get 'sessions/new'
  root   'static_pages#home'

  get    '/about',   to: 'static_pages#about'
  get    '/signup',  to: 'users#new'
  get    '/add_book',  to: 'books#new'

  get    '/login',   to: 'sessions#new'
  post   '/login',   to: 'sessions#create'
  delete '/logout',  to: 'sessions#destroy'

  get '/auth/:provider/callback' => 'sessions#omniauth'

  resources :users  
  resources :books
end
