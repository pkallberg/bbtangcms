BBTangCMS::Application.routes.draw do

  match "common/search", :as => :common_search



  namespace :kindeditor do
    #post "/upload" => "assets#create"
    match '/upload' => 'assets#create', :via => :post
    match '/filemanager' => 'assets#list', :via => :get
    #get  "/filemanager" => "assets#list"
  end

  namespace :tag do
    resources :identities , :only => [:index, :show, :new, :create] do
      resources :timelines, :only => [:index, :show, :new, :create] do
        resources :categories
      end
    end
    root :to => 'dashboard#show', :as => :dashboard
  end

  resources :questions do
    collection do
      get 'resetscore'
    end
    resources :answers
    #member do
    #  get 'refresh'
    #end
  end

  resources :knowledges do
    member do
      get 'refresh'
    end
  end

  #resources :profiles, :only => [:index, :show, :edit, :destroy]
  resources :profiles, :except => [:new, :create]
  namespace :recommend do
    resources :recommend_products
    resources :recommend_questions
    resources :recommend_users
    resources :recommend_events
    resources :recommend_mtools
    resources :recommend_subjects
    resources :recommend_quizzes
    resources :recommend_tags
    resources :recommend_hindices
    root :to => 'dashboard#show', :as => :dashboard
  end

  namespace :auth do
    resources :users
    resources :cms_roles
    resources :assign_permits
    root :to => 'dashboard#show', :as => :dashboard
  end


  devise_for :users

  root :to => 'dashboard#index'
  match "/archives/:model/" => "archives#index", :as => :archives, :via => :get
  match "/archives/savesort" => 'archives#savesort'
  match "/archives/search_tag" => 'archives#search_tag', :as => :search_tag
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
