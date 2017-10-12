Rails.application.routes.draw do
  resources :tops, only: :index
  resources :categories, only: :index
  resources :questions, only: :index
  resources :contacts, only: %w[new create]
  resources :blogs, only: %w[index] do
    collection do
      get :detail # FIXME: 本稼働の際には、書き直す
    end
  end

  devise_for :users, path: '', path_names: { sign_in: 'login', sign_out: 'logout' },
    controllers: { omniauth_callbacks: "users/omniauth_callbacks" }, skip: %w[session logout password regstration]

  as :user do
    get "sign_up" => "devise/regstrations#new"
    post "sign_up" => "devise/regstrations#create"
  end

  root 'tops#index'
end
