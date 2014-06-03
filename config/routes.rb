Ocd::Application.routes.draw do
  devise_for :admins
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  devise_for :users

  root :to => 'application#home'

  resources :time_slots

  resources :page_categories
  get 'blogs'                        => 'page_categories#blogs'

  resources :pages
  get 'job_scope_and_time_to_task'  => 'pages#job_scope_and_time_to_task'
  get 'terms_and_condition'         => 'pages#terms_and_condition'
  get 'disclaimer_privacy_policy'   => 'pages#disclaimer_privacy_policy'
  get 'faq'                         => 'pages#faq'
  get 'join_us'                     => 'pages#join_us'
  get 'about_us'                    => 'pages#about_us'

  get 'buy_package'                 => 'packages#buy_package'

  patch 'express_checkout'          => 'payments#express_checkout'

  get 'user_info'                   => 'users#info'

  get 'success_payment'             => 'payments#success_payment'
  get 'cancel_payment'              => 'payments#cancel_payment'
  resources :payments

  resources :feedbacks


  mount Ckeditor::Engine => '/ckeditor'

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
