ThermMonitor::Application.routes.draw do
  resources :issues

  resources :alarms

  resources :schedules

  resources :locations

  resources :history_thermostats
  post '/user/save' => 'thermostats#save'
  get '/users/create_user' => 'thermostats#create_user'
  get '/users/remove/:id' => 'thermostats#remove'
  get '/users/edit_user/:id' => 'thermostats#edit_user'
  devise_for :users do
  get '/users/sign_out' => 'devise/sessions#destroy'
   end 
  resources :thermostats

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".
  get '/admi/user/block/:id' => 'thermostats#block'
  get '/admi/user/unlock/:id' => 'thermostats#unlock'
  get '/admi/user/change_role/:id' => 'thermostats#change_role'
  get '/home' => 'locations#index', :as => 'locations_home'
  get '/admi' => 'thermostats#admi', :as => 'home'
  get '/admi/report' => 'thermostats#report', :as => 'report_thermostat'  
  get '/about_us' => 'thermostats#about'
  get '/locations/new' => 'locations#new', :as => 'location_thermostat'
  get '/thermostats/:id' => 'thermostats#show', :as => 'thermostat_show'
  get '/contact_us' => 'thermostats#contact'
  get '/history_thermostats/report/:id' => 'history_thermostats#report', :as => 'report_history'

  # You can have the root of your site routed with "root"
   root 'thermostats#index'
   get '/thermostats/destroy/:id' => 'thermostats#destroy'
   get '/thermostats/add/:id' => 'thermostats#add'
   get '/thermostats/sub/:id' => 'thermostats#sub'
   get '/issues/formulario/:id' => 'issues#formulario'
   get '/issues/new/:id' => 'issues#new'
   get '/issues/ver_problemas/:id' => 'issues#ver_problemas'

   get '/history_thermostats' => 'thermostats#history', :as => 'show_history'
   get '/home/:id/schedules' => 'schedules#index', :as => 'home_new_schedule'

  


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
