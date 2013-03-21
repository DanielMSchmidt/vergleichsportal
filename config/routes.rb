Vergleichsportal::Application.routes.draw do
  require 'sidekiq/web'

  scope ":locale", locale: /#{I18n.available_locales.join("|")}/ do

    mount Sidekiq::Web => '/sidekiq'

    get "password_resets/create"

    get "password_resets/edit"

    get "password_resets/update"

    resources :password_resets

    get "home/index" => "home#index"

    get "home/search" => "home#search_results"

    get "home/admin" => "home#admin", :as => 'admin_home'

    resources :carts

    get "carts/:id/delete" => "carts#destroy", as: 'delete_cart'

    get "carts/add/new" => "carts#add_new", as: 'add_new'

    get "carts/:cart_id/add/:article_id" => "carts#add_article", as: 'add_article'

    get "carts/:cart_id/remove/:article_id" => "carts#remove_article", as: 'remove_article'

    get "carts/:id/use" => "carts#use", as: 'use_cart'

    get "cart/add/:cart_id" => "users#addCart", as: 'add_cart_to_user'

    get "cart/add-compare" => "home#track_compare", as: 'track_compare'

    resources :users do
      member do
        get :activate
      end
    end

    get "users/:id/change_role" => "users#change_role", :as => "user_change_role"



    resources :user_sessions

    get "advertisment/:id/activate" => "advertisments#activate", :as => 'activate_advertisment'

    resources :advertisments

    match 'login' => 'user_sessions#new', :as => :login
    match 'logout' => 'user_sessions#destroy', :as => :logout


    get "user_sessions/new"

    get "user_sessions/create"

    get "user_sessions/destroy"

    resources :articles

    put "articles/:id/add_rating" => "articles#add_rating", :as => 'article_add_rating'
    put "articles/:id/add_comment" => "articles#add_comment", :as => 'article_add_comment'

    get "api/search"

    resources :providers

    put "providers/:id/add_rating" => "providers#add_rating", :as => 'provider_add_rating'

    root to: 'home#index'
  end
  match '*,path', to: redirect("/#{I18n.default_locale}/%{path}")
  match '', to: redirect("/#{I18n.default_locale}")

  root to: 'home#index'
end
