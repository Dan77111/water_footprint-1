Rails.application.routes.draw do

  devise_for :users, :skip => [:sessions, :registrations]
  # redefined uri for devise
  as :user do
    get 'login' => 'devise/sessions#new', :as => :login
    post 'login' => 'sessions#create'
    delete 'logout' => 'devise/sessions#destroy', :as => :logout

    get 'signup' => 'devise/registrations#new', :as => :signup
    post 'signup' => 'registrations#create'
  end

  root 'static_pages#home'

  get '/info' => 'static_pages#info'
  get '/calculator' => 'static_pages#calculator'
  post '/save_result_in_cookies' => 'static_pages#save_result_in_cookies'

  # results are nested in users
  resources :users, only: [:get, :post] do
    get '/results', to: 'results#index'
    post '/results', to: 'results#create'
  end

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

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
