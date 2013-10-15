Thecodecookbook::Application.routes.draw do
  resources :comments

  resources :recipes

  resources :users

  resource :session, :only => [:new, :create, :destroy]

  

  match '/activate/:activation_code' => 'users#activate', :as => :activate, :activation_code => nil

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
  # root :to => "welcome#index"

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id(.:format)))'
  
  #default route
  root :to => "home#index"
  
  #search
  match "/search"             => "search#search"
  match "/search/:topic"      => "search#search"
  match "/usersearch"         => "users#user_search"
  match "/usersearch/:topic"  => "users#user_search"
  match "/draftsearch"        => "users#draft_search"
  match "/draftsearch/:topic" => "users#draft_search"
  match "/contributionsearch" => "users#contribution_search"
  
  #restful-authentication
  match 'login' => 'sessions#new', :as => :login
  match 'logout' => 'sessions#destroy', :as => :logout
  match 'signup' => 'users#new', :as => :signup
  match 'register' => 'users#create', :as => :register
  match '/users/:id' => 'users#show', :as => :account

  #Users
  match '/profile/:id' => 'users#profile', :as => :profile

  #comments
  match '/comments/:user_id/recipes/:recipe_id' => 'comments#new', :as => :create_comment
  
  #recipes
  match '/recipes/:id' => 'recipes#show'
  match '/recipes_public/:id' => 'recipes#public_show'

  #drafts
  match '/drafts/:id' => 'users#drafts'

  #contributions
  match '/contributions/:id' => 'users#contributions'
  match '/deletecontributions/:id' => 'recipes#delete_contribution'
  
  #addrecipe
  match '/addrecipe/:id' => 'recipes#add_recipe'
end
