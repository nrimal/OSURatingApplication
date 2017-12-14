Rails.application.routes.draw do
  devise_for :users
  get 'result/showResult'

  get 'user/login'

  get 'user/signup'

  get 'user/viewProfile'

  get 'user/notLoggedIn'

  get 'home/index'

  get 'user' => "user#refresh"

  get 'error' => 'error#index'

  # Gets an empty form to add a review
  get 'facility/new'

  # Creates the review
  post 'facility' => 'facility#create'

  # Deletes a review
  delete 'facility' => 'facility#delete', :as => 'delete_post'

  # Gets the review data for a specific facility
  get 'facility/:facilityId' => 'facility#show'

  #routes to result controller, and showResult method when 'result/showResult' is called
  get 'result/showResult' => "result#showResult"

  root 'home#index'

  # Gets page for each room
  get 'room_page/roomInfo'

  # Gets edit review page
  get 'facility/edit'
  # Edits review
  post 'facility/editReview' => 'facility#editReview'

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  # root 'welcome#index'

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
