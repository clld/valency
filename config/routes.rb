Valency::Application.routes.draw do

  # routes for language-specific resources
  resources :languages, :only => [:show, :index] do
    
    resources :verbs,         :only => [:show, :index]
    resources :coding_frames, :only => [:show, :index]
    resources :coding_sets,   :only => [:show, :index]
    resources :alternations,  :only => [:show, :index]
    resources :examples,      :only => [:show, :index]
    
  end
  
  resources :coding_frames, :only => [:index]
  
  resources :meanings,      :only => [:show, :index]
  
  resources :microroles,    :only => [:show, :index]
  
  resources :references,    :only => [:show, :index]
  
  resources :people,        :only => [:show, :index]
  
  
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

  match '/languages/iso/:id' => 'languages#showViaISOCode'
  match '/languages/glottolog/:id' => 'languages#showViaGlottologCode'

  match '/about' => 'application#about'
  match '/about/:name' => 'application#about'

  # have the root of your site routed with "root"
  # (root will redirect to public/index.html otherwise)
  root :to => 'application#home'

  # See how all your routes lay out with "rake routes"
end
