DevopsKeychain::Application.routes.draw do
  devise_for :users
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
     root 'application#root'

  # Example of regular route:
     get 'key' => 'privatekeys#new'
     get 'key/create' => 'privatekeys#create'
     get 'admin' => 'users#list'
     get 'users/new' => 'users#new'
     get 'users/create' => 'users#create'
     get 'users' => 'users#show'
     get 'deployments/new' => 'deployment#new'
     get 'deployments/:id' => 'deployment#show'
     post 'secure' => 'secure_content#show'

     post 'environment/update' => 'environment#update'
     post 'secure_content/update' => 'secure_content#update'
     post 'secure_content/create'  => 'secure_content#create'
     post 'secure_content/delete'  => 'secure_content#delete'
     post 'deployment/create'  => 'deployment#create'
     post 'environment/create' => 'environment#create'

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
