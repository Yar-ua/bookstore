Rails.application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)

  devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth_callbacks' }

  root to: 'pages#index'
  resources :books, only: %i[show index] do
    resources :reviews, only: :create
    member do
      post 'add_to_cart'
    end
  end
  resource :cart, only: %i[edit update]
  resources :settings, only: :new
  resources :accounts, only: %i[update destroy]
  resources :addresses, only: :create
  resources :settings_email, only: :update

  namespace :checkouts do
    resource :login, only: %i[show]
    resource :address, only: %i[show update]
    # resource :delivery, only: %i[show update]
    # resource :payment, only: %i[show update]
    # resource :order, only: :create
    # resource :confirm, only: :show
    # resource :complete, only: :show
  end
end
