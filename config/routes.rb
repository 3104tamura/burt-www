Rails.application.routes.draw do
  get "/faq" => redirect('/questions')
  get "/contact" => redirect('contacts/new')
  get "/blog" => redirect('blogs')
  get "/blog_details" => redirect('blogs/detail')
  get "/single" => redirect('traning/detail')

  resources :tops, only: :index
  resources :categories, only: :index
  resources :questions, only: :index
  resources :contacts, only: %w[new create]
  resources :blogs, only: %w[index] do
    collection do
      get :detail # FIXME: 本稼働の際には、書き直す
    end
  end
  resources :training, only: %w[new] do
    collection do
      get :detail # FIXME: 本稼働の際には、書き直す
    end
  end

  devise_for :users, path: '', path_names: { sign_in: 'login', sign_out: 'logout' },
                     controllers: { omniauth_callbacks: 'users/omniauth_callbacks', registrations: "registrations"}, skip: %w[session logout password regstration]

  as :user do
    get 'sign_up' => 'devise/regstrations#new'
    post 'sign_up' => 'devise/regstrations#create'
  end

  resources :thanks, only: %w[index]

  namespace :admin do
    resources :users, only: %w[index]
  end

  root 'tops#index'

  match '*not_found' => 'application#routing_error', via: %w[get post]
end
