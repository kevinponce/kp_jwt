# frozen_string_literal: true

Rails.application.routes.draw do
  post 'users_auth' => 'users_auth#create'
  put 'users_auth' => 'users_auth#update'
  get 'secure' => 'secure#index'
end
