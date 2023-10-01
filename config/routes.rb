# frozen_string_literal: true
require 'sidekiq/web'
Sidekiq::Web.use ActionDispatch::Cookies
Sidekiq::Web.use ActionDispatch::Session::CookieStore, key: "_interslice_session"
Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  root 'home#index'

  # post "/api/v1/auth/register", to: "auth#register"
  # post "/api/v1/auth/login", to: "auth#login"

  mount Sidekiq::Web => "/sidekiq" # mount Sidekiq::Web in your Rails app
  mount Api::Base => '/'
end
