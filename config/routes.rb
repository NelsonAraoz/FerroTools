CatalogoVentas::Application.routes.draw do
  resources :locations

  devise_for :users#, controllers: {registrations: 'registrations'}
  get "welcome/index"
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".
   get "categories/new" => "categories#new"
   post "categories/create" => "categories#create"
   get "categories/edit/:id" => "categories#edit"
   post "categories/destroy" => "categories#destroy"
   post "subcategories/destroy" => "subcategories#destroy"
   post "categories/update" => "categories#update"
   get "subcategories/edit/:id" => "subcategories#edit"
   post "subcategories/update" => "subcategories#update"
   get "pictures/delete/:id" => "pictures#delete"
    get "products/edit/:id" => "products#edit"
    post "products/create" => "products#create"
     post "products/destroy" => "products#destroy"
        post "orders/destroy" => "orders#destroy"
   post "orders/create" => "orders#create"
    get "orders/new/:id" => "orders#new"
     get "orders/my_orders" => "orders#my_orders"
     get "orders/all_orders" => "orders#all_orders"
     get "orders/my_checked_orders" => "orders#my_checked_orders"
    get "subcategories/new/:id" => "subcategories#new"
   post "subcategories/create" => "categories#create"
     get "products/new/:id" => "products#new"
   post "products/create" => "products#create"
  get "categories/:id" => "categories#display", :as=>"display1"
  get "categories/:id/:subid" => "categories#display", :as=>"display2"
   get "categories/:id/:subid/:prodid" => "products#view", :as=>"display3"
  get "pictures/new" => "pictures#new"
  post "orders/uncheck/:id" => "orders#uncheck", :as => "uncheck"
  post "orders/confirm_order" => "orders#confirm"
  post "orders/:id" => "orders#update"

  post "pictures/create" => "pictures#create"
  # You can have the root of your site routed with "root"
   root 'welcome#index'
resources :pictures, only: [:create]
resources :products, only: [:create,:update,:destroy]
resources :categories, only: [:create,:update,:destroy]
resources :subcategories, only: [:create,:update,:destroy]
resources :orders , only: [:create,:update,:destroy]
  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Example resource route with options:
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

  # Example resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Example resource route with more complex sub-resources:
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', on: :collection
  #     end
  #   end

  # Example resource route with concerns:
  #   concern :toggleable do
  #     post 'toggle'
  #   end
  #   resources :posts, concerns: :toggleable
  #   resources :photos, concerns: :toggleable

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end
end
