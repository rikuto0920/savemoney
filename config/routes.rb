Rails.application.routes.draw do
  get 'rooms/show'
  devise_for :users

  # ✅ これを追加（drawの内側！）
  devise_scope :user do
    delete 'users/sign_out', to: 'devise/sessions#destroy'
  end

  root "students#index"

  get 'how_to_use', to: 'pages#how_to_use'

  
  resources :users, only: [:index, :show]
  resources :messages, only: [:create, :destroy]
  resources :rooms, only: [:create, :show]
  
  resources :students do
    resources :likes, only: [:create, :destroy]
    resources :comments, only: [:create]
  end

  mount ActiveStorage::Engine => "/rails/active_storage"
end
