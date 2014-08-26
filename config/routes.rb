ServicesKpis::Application.routes.draw do
  resources :users
  resources :sessions, only: [:sign_in, :create, :destroy, :edit]
  resources :projects
  resources :report_cards
  resources :surveys
  root  'services#home'
  match '/surveys/new/:id', to: 'surveys#new', via: 'get', as: 'surveys/new'
  match '/new_project',    to: 'projects#new_project',    via: 'get'
  match '/sign_in',    to: 'sessions#new',    via: 'get'
  match '/sign_out', to: 'sessions#destroy', via: 'delete'
  match '/sign_up',    to: 'users#sign_up',    via: 'get'
  match '/home',    to: 'services#home',    via: 'get'
  match '/users', to: 'users#users', via: 'get'
  match '/new_report_card',    to: 'report_cards#new_report_card',    via: 'get'
  match '/report_cards', to: 'report_cards#show', via: 'get'
  match '/all_report_cards', to: 'report_cards#show', via: 'get'
  match '/all_projects', to: 'projects#show', via: 'get'
  match '/my_report_cards/:id', to: 'users#my_report_cards', via: 'get', as: 'my_report_cards'
  match '/my_projects/:id', to: 'users#my_projects', via: 'get', as: 'my_projects'
  match '/team_charts', to: 'teams#team_charts', via: 'get'
  match '/new_survey_page_two', to: 'surveys#new_survey_page_two', via: 'get', as: :new_survey_page_two
  match '/teams', to: 'projects#team_charts', via: 'get'
  get "surveys/new"
  get "surveys/create"
  get "surveys/update"
  get "surveys/edit"
  get "surveys/destroy"
  get "surveys/index"
  get "surveys/show"
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
