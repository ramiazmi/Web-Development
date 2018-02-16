Rails.application.routes.draw do    
  resources :grant_sectors

  match 'proposal_assessment_summaries/:proposal_id' => 'proposal_assessment_summaries#complete', :as => :complete_assessment, :via => :patch
  match 'proposal_assessment_summaries/:proposal_id/:user_id' => 'proposal_assessment_summaries#reset_assessment', :as => :reset_eval_assessment, :via => :patch
  match 'grants/:grant_id/reset_grant' => 'grants#reset_grant', :as => :reset_grant, :via => :patch
  
  match 'active_grant_sectors/all/gs_edit' => 'grant_sectors#gs_edit_all', :as => :gs_edit_all, :via => :get
  match 'active_grant_sectors/gs_all' => 'grant_sectors#gs_update_all', :as => :gs_update_all, :via => :put

  match 'proposals/select_winners' => 'proposals#update_selection', :as => :select_winners, :via => :put

  resources :funds
  resources :fund_sources
  resources :localities
  resources :proposals do
    resources :geographic_coverages, :budgets, :funds
    member do
      patch :complete
    end
  end

  resources :development_goals
  resources :sectors
  resources :provinces
  # get 'home/home_index'

  match 'home' => 'home#home_index', :as => :home, :via => :get
  match 'reports' => 'reports#index', :as => :reports, :via => :get
  match 'reports/statistics' => 'reports#statistics', :as => :reports_statistics, :via => :get
  match 'reports/assessments_mark_order' => 'reports#assessments_mark_order', :as => :reports_assessments_mark_order, :via => :get
  match 'reports/assessments_province_order' => 'reports#assessments_province_order', :as => :reports_assessments_province_order, :via => :get
  match 'reports/assessments_report/:proposal_id' => 'reports#assessments_rep', :as => :assessments_rep, :via => :get

  devise_for :users, except: [:new, :update]
  devise_scope :user do
    # get "users", to: "users/registrations#index", as: "edit_user"
    get "users/sign_up", to: "users/registrations#new", as: "new_app_user"
    put "/app_users/:id", to: "users/registrations#update", as: "update_app_user"
    patch "/app_users/:id", to: "users/registrations#update"
  end 

  as :user do
    get "/users", to: "registrations#admin_index", as: "admin_users"
    post "/add_user", to: "registrations#create", as: "create_user"
    get "/users/new", to: "registrations#admin_new", as: "admin_new_user"
    get "/users/admin_edit/:id", to: "registrations#admin_edit", as: "admin_edit_user"
    get "/admin_users/:id", to: "registrations#admin_show", as: "show_user"
    put "/users/:id", to: "registrations#update", as: "update_user"
    patch "/users/:id", to: "registrations#update"
    
  end

  resources :grants do
    member do
      patch :close
    end
  end

  resources :assessments 
  
  resources :categories
  resources :criterions do
    resources :criterion_details 
  end
  
  match 'e_assessments/edit/:proposal_id' => 'assessments#edit_all', :as => :edit_all, :via => :get 

  match 'e_assessments/update_all' => 'assessments#update_all', :as => :update_all, :via => :put 

  match 'users/:id/add_proposal' => 'proposals#add_proposal', :as => :add_proposal, :via => :post

  match 'proposals/:id' => 'proposals#update', :as => :add_geographic_coverage, :via => :post
  match 'proposals/:id' => 'proposals#update', :as => :add_budget, :via => :post
  match 'proposals/:id' => 'proposals#update', :as => :add_fund, :via => :post

  # match 'users/all/edit/:proposal_id' => 'assessments#update', :as => :add_assessment_criterion_details, :via => :post
  
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  root to: "home#home_index"
  # root 'welcome#index'

  #To redirect all routing error to home page
  get '*a', :to => "home#home_index"

end
