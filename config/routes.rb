CatalogoVentas::Application.routes.draw do

  
  devise_for :users#, controllers: {registrations: 'registrations'}
  get "welcome/index"
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".
  get 'categories/dependencies/:id' => 'categories#dependencies'

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
     get "orders/user_orders/:id" => "orders#my_orders"
     get "orders/delete_items/:id" => "orders#delete_items"
     post "orders/remove_orders/:id" => "orders#remove_orders"
     post "orders/remove_order/:id" => "orders#remove_order"
     post "orders/add_order/:id" => "orders#add_order"
     get "orders/all_orders" => "orders#all_orders"
     get "orders/remove_kart/:id" => "orders#remove_kart"
     post "orders/removing_from_kart/:id" => "orders#removing_from_kart"
    
     get "orders/my_checked_orders" => "orders#my_checked_orders"
     get "orders/my_checked_orders/:id" => "orders#my_checked_orders"
     get "orders/my_sended_orders/:id" => "orders#my_sended_orders"
  get "orders/messenger_orders/:messenger_id" => "orders#my_sended_orders"
  
     get "orders/view_order/:id" => "orders#view_order"
     get "orders/my_sended_orders" => "orders#my_sended_orders"
    get "subcategories/new/:id" => "subcategories#new"
    get 'products/search' => 'products#search'
   post "subcategories/create" => "categories#create"
     get "products/new/:id" => "products#new"
   post "products/create" => "products#create"
  get "categories/:id" => "categories#display", :as=>"display1"
  get "categories/:id/:subid" => "categories#display", :as=>"display2"
   get "categories/:id/:subid/:prodid" => "products#view", :as=>"display3"
  get "pictures/new" => "pictures#new"
  post "orders/uncheck/:id" => "orders#uncheck", :as => "uncheck"
  post "orders/uncheck_send/:id" => "orders#uncheck_send", :as => "uncheck_send"
  post "shippings/confirm_shipping_send/:id" => "shippings#confirm_shipping_send"
  post "orders/confirm_order" => "orders#confirm"
post "shippings/update_shipping_send/:id" => "shippings#update_shipping_send"
  get 'locations/index/:id' => 'locations#index'
  post "users/login_service" => 'users#login_service'
  get "locations/asd/:id" => "locations#asd"
  post "orders/get_my_orders_locations" => "orders#get_my_orders_locations"
    get "shippings/get_shippings/:id" => "shippings#get_shippings"
  post "orders/:id" => "orders#update"
 get "orders/edit_checked_orders" => "orders#edit_checked_orders"
 post '/users/admin_change_password/:id' => 'users#admin_change_password'
  post "locations/login" => "locations#login"
  post "pictures/create" => "pictures#create"
  get "users/change_password" => "users#change_password"
  post "users/update_password" => "users#update_password"
  get "locations/login/:name/:pass" => "locations#login"
  get 'presentations/edit' => 'presentations#edit'
  post 'presentations/update' => 'presentations#update'
  get 'presentations/show' => 'presentations#show'
  get 'users/new_messenger' => 'users#new_messenger', :as => 'new_messenger'
  get 'users/edit_messenger/:id' => 'users#edit_messenger', :as => 'edit_messenger'
  post 'users/update_messenger/:id' => 'users#update_messenger', :as => 'update_messenger'
  post 'users/create_messenger' => 'users#create_messenger'
  get 'users/messenger_index' => 'users#messenger_index', :as => 'messenger_index'
  post 'locations/asd' => 'locations#asd'
  get 'shippings/index/:id' => 'shippings#index'
  get 'shippings/new/:id' => 'shippings#new'
    get 'shippings/show/:id' => 'shippings#show'
  get 'shippings/edit/:id' => 'shippings#edit'
  get 'delivers/show/:id' => 'delivers#show'
  post 'delivers/change_location/:id' => 'delivers#change_location'
  get 'delivers/delete_deliver' => 'delivers#delete_deliver'
   post 'delivers/return_to_cart/:id' => 'delivers#return_to_cart'
 
  get 'shippings/remove/:id' => 'shippings#remove'
  post 'shippings/destroy/:id' => 'shippings#destroy'
   get 'shippings/edit_data/:id' => 'shippings#edit_data'
   get 'orders/remove_user_request' => 'orders#remove_user_request'
   post 'shippings/update_data/:id' => 'shippings#update_data'
   post 'shippings/create/:id' => 'shippings#create'
post 'orders/confirm_order_send/:id' => 'orders#confirm_order_send'
get 'delivers/get_deliveries' =>'delivers#get_deliveries'
post 'delivers/deliveries_table' => 'delivers#deliveries_table'
get 'delivers/deliveries_table' => 'delivers#deliveries_table'

post 'delivers/remove_all/:id' => 'delivers#remove_all'
post 'delivers/get_deliveries' =>'delivers#get_deliveries'
get 'delivers/get_deliveries' =>'delivers#get_deliveries'
post 'messenger_locations/update' => 'messenger_locations#update'
get 'messenger_locations/update' => 'messenger_locations#update'
get 'messenger_locations/show/:id' => 'messenger_locations#show'
get 'messenger_locations/get_location/:id' => 'messenger_locations#get_location'
get 'products/dependencies/:id' => 'products#dependencies'
get 'subcategories/dependencies/:id' => 'subcategories#dependencies'

post 'delivers/change_status' => 'delivers#change_status'
post 'shippings/edit_status/:id' => 'shippings#edit_status'
post 'packages/create/:shipping_id/:order_id' => 'packages#create'
post 'packages/remove/:id' => 'packages#remove'
post 'shippings/destroy/:id' => 'shippings#destroy'
post 'shippings/confirm/:id' => 'shippings#confirm'
  # You can have the root of your site routed with "root"
   root 'presentations#show'
   resources :locations
resources :users, only: [:index]
  resources :users, only: [:create,:update,:destroy] 
resources :pictures, only: [:create]
resources :presentations, only: [:update]
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
