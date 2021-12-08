Rails.application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)

  devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth_callbacks' }
  
  root to: 'pages#index'
  resources :books, only: [:show, :index] do
    resources :reviews, only: :create
  end
  resources :settings, only: :new
  resources :accounts, only: %i[update destroy]
  resources :addresses, only: :create
  resources :settings_email, only: :update
end
