# frozen_string_literal: true

Rails.application.routes.draw do

  get 'books/new'
  get 'books/edit'
  get 'books/index'
  get 'books/show'

  #get 'sessions/new'
  root   'static_pages#home'

  get    '/about',   to: 'static_pages#about'
  get    '/signup',  to: 'users#new'

  get    '/login',   to: 'sessions#new'
  post   '/login',   to: 'sessions#create'
  delete '/logout',  to: 'sessions#destroy'

  get '/auth/:provider/callback' => 'sessions#omniauth'

  resources :users  
end
