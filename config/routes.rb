Rails.application.routes.draw do


  get 'data/enter'

  get 'data/search'
  get 'data/getdata'



get "log_out" => "users#logout", :as => "log_out"
get "log_in" => "users#login", :as => "log_in"
get "sign_up" => "users#new", :as => "sign_up"
get 'confirmation/:key' => 'users#confirmation' ,:as => "confirmation"
post 'confirmation_pro' => 'users#confirmation_pro'

get '/users/chng_pass' => 'users#chngpass' ,:as => "chng_pass"
post '/users/chng_pass' => 'users#chngpass_pro' ,:as => "chng_pass_pro"


post "auth" => "users#auth", :as => "auth"

root :to => "users#login"


get 'events/search_dates' => 'events#searchevents_date' ,:as => "search_dates"
post 'getevents' => 'events#getevents' ,:as => "getevents"



  resources :users
  resources :attendees


resources :groups do
		resources :events do
  			resources :comments
        resources :photos
		end
	end
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  #  root 'welcome#index'

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
