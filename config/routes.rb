BBTangCMS::Application.routes.draw do



  # admin
  namespace :admin do
    # 基本设置
    resources :base_settings, :include => [:index] do
      collection do
        #match 'index'
        match 'save'
        match 'add_report_reason'
        match 'delete_report_reason'
      end
    end
    #match "base_settings/index" => "base_settings#index"
    #match "base_settings/save" => "base_settings#save"
    #match "base_settings/add_report_reason" => "base_settings#add_report_reason"
    #match "base_settings/delete_report_reason" => "base_settings#delete_report_reason"

    # 邮件设置
    resources :email_settings, :include => [:index] do
      collection do
        match 'save'
        match 'send_test_email'
      end
    end
    #match "email_settings/index" => "email_settings#index"
    #match "email_settings/save" => "email_settings#save"
    #match "email_settings/send_test_email" => "email_settings#send_test_email"

    # 代码参数设置
    resources :code_settings

    # 友情链接
    resources :links_settings, :include => [:index] do
      collection do
        match 'new_link'
        match 'create_link'
        match 'edit_link'
        match 'update_link'
        match 'delete_link'
      end
    end

    #match "links_settings/index" => "links_settings#index"
    #match "links_settings/new_link" => "links_settings#new_link"
    #match "links_settings/create_link" => "links_settings#create_link"
    #match "links_settings/edit_link" => "links_settings#edit_link"
    #match "links_settings/update_link" => "links_settings#update_link"
    #match "links_settings/delete_link" => "links_settings#delete_link"

    # SEO设置
    resources :seo_settings

    # 访问IP设置
    resources :ip_settings do
      collection do
        post :save
      end
    end

  end

  resources :attachments

  namespace :auth do
    resources :users
    resources :cms_roles
    resources :assign_permits
    root :to => 'dashboard#show', :as => :dashboard
  end

  resources :news

  namespace :kindeditor do
    #post "/upload" => "assets#create"
    match '/upload' => 'assets#create', :via => :post
    match '/filemanager' => 'assets#list', :via => :get
    #get  "/filemanager" => "assets#list"
  end

  resources :knowledges do
    member do
      get 'refresh'
    end
  end

  #resources :profiles, :only => [:index, :show, :edit, :destroy]
  resources :profiles, :except => [:new, :create]
  resources :page_requests

  resources :questions do
    collection do
      get 'resetscore'
      match 'update_timelines'
      match 'update_categories'
    end
    resources :answers
  end

  namespace :recommend do
    resources :recommend_products
    resources :recommend_questions
    resources :recommend_users
    resources :recommend_events
    resources :recommend_mtools
    resources :recommend_subjects
    resources :recommend_quizzes
    resources :recommend_tags
    resources :recommend_ptags
    resources :recommend_hindices
    root :to => 'dashboard#show', :as => :dashboard
  end

  resources :subjects

  namespace :tag do
    resources :identities , :only => [:index, :show, :new, :create] do
      resources :timelines, :only => [:index, :show, :new, :create] do
        resources :categories
      end
    end
    root :to => 'dashboard#show', :as => :dashboard
  end


  namespace :work do
    resources :versions, only: [:index, :show ]
    root :to => 'dashboard#show', :as => :dashboard
  end

  devise_for :users

  match "common/search", :as => :common_search
  root :to => 'dashboard#index'
  match "/archives/hot_tags/" => "hot_tags#index", :as => :hot_tags, :via => :get
  match "/archives/:model/" => "archives#index", :as => :archives, :via => :get
  match "/archives/savesort" => 'archives#savesort'
  match "/archives/search_tag" => 'archives#search_tag', :as => :search_tag
  match '/archives/:model/item_list/:item_id/' => "archives#item_list", :as => :archive_item_list, :via => :get


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
