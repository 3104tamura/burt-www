Rails.application.routes.draw do
  resources :tops, only: :index
  resources :categories, only: :index

  root 'tops#index'
end
