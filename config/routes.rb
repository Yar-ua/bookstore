Rails.application.routes.draw do
  root to: 'pages#index'
  get '/catalog', to: 'books#index'
  resources :books, only: :show
end
