Rails.application.routes.draw do

  # devise_for :users
  devise_for :users, :path_names => {
    :sign_in => 'login',
    :sign_out => 'logout',
    :sign_up => 'register'
  }

  root :to => 'home#index'

  localized do
    resources :users
    resources :article_categories
    resources :articles do
      member do
        get :additional_pictures
        post :update_additional_pictures
      end
    end
    resources :cities
    resources :game_categories
    resources :game_comments
    resources :game_labels
    resources :games
    resources :houses

    get 'map', to: 'map#index', as: :map
    get 'game_ratings', to: 'game_ratings#index', as: :game_ratings
  end

  scope :path => '/home', :controller => :home, :as => :home do
    get :index
  end

  resources :pictures do
    collection do
      get :new_multi
      post :create_multi
    end
  end


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

