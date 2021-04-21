Rails.application.routes.draw do
  root to: 'home#index'
  get '/catalog', to: 'books#index'
  resources :books, only: :show
end
