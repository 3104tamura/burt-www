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

  devise_for :users, path: 'users', path_names: { sign_in: 'login', sign_out: 'logout' },
                     controllers: { sessions: 'users/sessions', registrations: "users/registrations" }, skip: %w[logout password]

  devise_for :trainers, path: 'trainers', path_names: { sign_in: 'login', sign_out: 'logout' },
                     controllers: { sessions: 'trainers/sessions', registrations: "trainers/registrations" }, skip: %w[logout password]


  devise_scope :user do
    get "/auth/user_from_facebook/callback" => "users#from_facebook"
  end

  devise_scope :trainer do
    get "/auth/trainer_from_facebook/callback" => "trainers#from_facebook"
  end

  resources :trainers, only: %w[index edit update]

  resources :thanks, only: %w[index]

  namespace :admin do
    resources :users, only: %w[index]
    resources :trainers, only: %w[index]
  end

  root 'tops#index'

  # match '*not_found' => 'application#routing_error', via: %w[get post]
end
