Rails.application.routes.draw do
  root to: 'pages#index'
  resources :books, only: %i[show index]
end
