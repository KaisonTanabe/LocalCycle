LOCALCYCLE::Application.routes.draw do

  resources :categories

  resources :agreements do
    get 'marketplace', :on => :collection
  end

  resources :buyer_profiles, only: ["new","create"]

  resources :producer_profiles, only: ["new","create"]

  resources :products do
    get 'pic', :on => :member
  end

  devise_for :users, path_prefix: "d", path_names: { sign_in: 'login', sign_up: 'register' }, 
    controllers: {confirmations: 'confirmations', sessions: 'sessions', registrations: 'registrations'}

  devise_scope :user do
    put '/confirm' => 'confirmations#confirm', as: :user_confirm
    get '/login', :to => "devise/sessions#new"
    get '/register', :to => "registrations#new"
  end

  resources :users

  # Temporary model to collect email addresses on BETA page
  resources :leads, only: "create"

  # Reserved for admin to test different user views
  match 'become' => "users#become"

  root :to => 'public#index'

  # Public pages
  match "faq" => 'public#faq'
  match "about" => 'public#about'
  match "contact" => 'public#contact'
  match "test" => 'public#test'

end
