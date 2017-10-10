Rails.application.routes.draw do
  resources :tops, only: :index
  resources :categories, only: :index
  resources :questions, only: :index

  root 'tops#index'
end
