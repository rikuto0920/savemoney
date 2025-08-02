require "active_storage/engine"

Rails.application.routes.draw do
  get 'rooms/show'
  devise_for :users

  root "users#index"

  resources :users, only: [:index, :show]
  resources :messages, only: [:create, :destroy]
  resources :rooms, only: [:create, :show]
  
  resources :students do
    resources :likes, only: [:create, :destroy]
    resources :comments, only: [:create]
  end

  mount ActiveStorage::Engine => "/rails/active_storage"
end
