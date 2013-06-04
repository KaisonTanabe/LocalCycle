LOCALCYCLE::Application.routes.draw do

  resources :categories

  resources :products do
    get 'pic', :on => :member
    get 'export', :on => :collection
  end

  resources :agreements do
    get 'modal', :on => :member
    put 'accept', :on => :member
    get 'marketplace', :on => :collection
    get 'table', :on => :collection
    get 'export', :on => :collection
    resources :agreement_changes, as: "change", only: ["new","create","update"] do
      post 'chain', :on => :collection
    end
  end

#  resources :buyer_profiles, only: ["new","create","show"]
#  resources :producer_profiles, only: ["new","create","show"]

  devise_for :users, path_prefix: "d", path_names: { sign_in: 'login', sign_up: 'register' }, 
    controllers: {confirmations: 'confirmations', sessions: 'sessions', registrations: 'registrations'}

  devise_scope :user do
    put '/users/confirm' => 'confirmations#confirm', as: :user_confirm
    get '/login', :to => "devise/sessions#new"
    get '/register', :to => "registrations#new"
  end

  resources :users do
    get 'prompt', :on => :member
  end

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
