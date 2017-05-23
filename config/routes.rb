Rails.application.routes.draw do
  
  

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  #root 'main#search_result_view' ##두번째 화면(검색한 뒤에) 
  #root 'main#search_view' ## 첫 화면
  
  
  
  #root 'detail#detail_program' ##손지짱 꺼임  
  #root 'apply#apply_form'
  
  #손지짱 손지짱 손지짱 손지짱 바보 똥개 멍충이
  #get '/detail_program' => 'detail#detail_program'
  get '/detail_explanation' => 'detail#explanation'
  get '/detail_echo_village' => 'detail#echo_village'
  get '/detail_prenatal' => 'detail#prenatal'
  get '/detail_lodge' => 'detail#lodge'
  get '/detail_arboretum' => 'detail#arboretum'
  get '/detail_program' => 'detail#program'
  
  get '/like' => 'detail#likeup'
  get '/nonlike' => 'detail#likedown'
  get '/program_likeup' => 'detail#program_likeup'
  get '/program_likedown' => 'detail#program_likedown'
  
  

  #석현님꺼 테스트
  root 'main#search_view' 
  get '/search' => 'main#search_result_view'
  get '/test' => 'main#temp'
  get '/apply_program' =>'detail#apply_program'
  #get "/result" => "chesse#other"
  #root 'home#index'
  # You can have the root of your site routed with "root"
  # root 'welcome#index'



 #만중꺼

 get '/login' => 'login#login'
 post '/login' => 'login#login'

 
 post '/intro_dashboard' => 'dashboard#intro_dashboard'
 get '/intro_dashboard' => 'dashboard#intro_dashboard'
 
 post '/booker_check' => 'dashboard#booker_check'
 get '/booker_check' => 'dashboard#booker_check'
 
 
 
 post '/check_day_program' => 'dashboard#check_day_program'
 get '/check_day_program' => 'dashboard#check_day_program'
 
 
 
 
 post '/dashboard4' => 'dashboard#dashboard4'
 get '/dashboard4' => 'dashboard#dashboard4'
 post '/dashboard5' => 'dashboard#dashboard5'
 get '/dashboard5' => 'dashboard#dashboard5'
 
 get 'tempdatastore' => 'dashboard#tempdatastore'


post '/dashboard_test' => 'dashboard#dashboard_test'
 get '/dashboard_test' => 'dashboard#dashboard_test'


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
