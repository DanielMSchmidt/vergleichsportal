Vergleichsportal::Application.routes.draw do
  resources :password_resets

  get "home/index"

  get "home/search_results"

  get "home/admin"

  resources :carts

  resources :users do
    member do
      get :activate
    end
  end


  resources :user_sessions

  resources :advertisments

  match 'login' => 'user_sessions#new', :as => :login
  match 'logout' => 'user_sessions#destroy', :as => :logout


  get "user_sessions/new"

  get "user_sessions/create"

  get "user_sessions/destroy"

  resources :articles


  get "api/search"

  resources :providers

  root to: 'home#index'

end
