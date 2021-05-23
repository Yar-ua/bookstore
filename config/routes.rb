Rails.application.routes.draw do
  devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth_callbacks' }

  root to: 'pages#index'
  resources :books, only: %i[show index]
  resources :settings, only: [:new, :create]
  resources :address, only: :create
end
