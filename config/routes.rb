Vergleichsportal::Application.routes.draw do
  require 'sidekiq/web'
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

  put "providers/add/provider" => "providers#add_provider", :as => 'add_provider'

  root to: 'home#index'

  # Android API routes

  post "android/login" => "android#check_auth"
  post "android/register" => "android#register"

  get "android/provider" => "android#provider"
  post "android/provider" => "android#rate_provider"

  post "android/article/rate" => "android#rate_article"
  post "android/article/comment" => "android#comment_article"
  post "android/article/comments" => "android#comments_for_article"
  
  get "android/debug" => "android#debug"

  post "android/search" => "android#search"

  post "android/carts" => "android#all_carts"
  post "android/cart/articles" => "android#articles_for_cart"
  post "android/cart/articles/add" => "android#add_article"
  post "android/cart/articles/remove" => "android#remove_article"

  # The priority is based upon order of creation:
  # first created -> highest priority.

  # Sample of regular route:
  #   match 'products/:id' => 'catalog#view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  #   match 'products/:id/purchase' => 'catalog#purchase', :as => :purchase
  # This route can be invoked with purchase_url(:id => product.id)

  # Sample resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Sample resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Sample resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Sample resource route with more complex sub-resources
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', :on => :collection
  #     end
  #   end

  # Sample resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end

  # You can have the root of your site routed with "root"
  # just remember to delete public/index.html.
  # root :to => 'welcome#index'

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id))(.:format)'
end
