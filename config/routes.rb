LOCALCYCLE::Application.routes.draw do

  resources :categories

  resources :products do
    get 'pic', on: :member
    get 'export', on: :collection
  end

  resources :price_points

  resources :goods do
    get 'toggle_available', on: :member
    get 'marketplace', on: :collection
    get 'export', on: :collection
    get 'buyer_panel', on: :collection
  end

  resources :markets do
    get 'export', on: :collection
  end
  resources :networks do
    get 'export', on: :collection
  end
  
  resources :agreements do
    get 'root_agreement_changes', on: :member
    put 'accept', on: :member
    get 'marketplace', on: :collection
    get 'table', on: :collection
    get 'export', on: :collection
    resources :agreement_changes, only: ["new","create","update"] do
      post 'chain', on: :collection
    end
  end

  devise_for :users, path_prefix: "d", path_names: { sign_in: 'login', sign_up: 'register' },
    controllers: {confirmations: 'confirmations', sessions: 'sessions', registrations: 'registrations'}

  devise_scope :user do
    put '/users/confirm' => 'confirmations#confirm', as: :user_confirm
    get '/login', :to => "devise/sessions#new"
    get '/register', :to => "registrations#new"
  end

  resources :users do
    get 'prompt', on: :member
    get 'export', on: :collection
    member do 
      post 'activate'
      
    end
  end

  resources :wishlists
  
  resources :carts do
    member do
      post 'add_item' 
      get 'checkout'
    end
    
  end
  
  # Temporary model to collect email addresses on BETA page
  resources :leads, only: "create"

  # Reserved for admin to test different user views
  match 'become' => "users#become"

  root :to => 'public#index'

  # Public pages
  match "for-farmers" => 'public#for_farmers'
  match "for-buyers" => 'public#for_buyers'
  match "about-us" => 'public#about_us'
  match "contact" => 'public#contact'
  match "test" => 'public#test'
  match "d/users" => 'public#index'

end
