Rails.application.routes.draw do
  devise_for :users
  root to: 'pages#index'
  resources :books, only: %i[show index]
end
