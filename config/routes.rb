NegocioChimbarongo::Application.routes.draw do

  get "welcome/index"

  devise_for :usuarios
  
  devise_scope :usuario do
    authenticated :usuario do
      root 'welcome#index'

      get "sign_out", :to => "devise/sessions#destroy"
      resources :usuarios

      resources :pagos

      match 'pagos' => 'pagos#seleccionar', :via => :get, as: :seleccionar

      match 'pagos/cliente/:id' => 'pagos#pagos', :via => :get, as: :pagos_cliente

      match 'pagos/pagar/venta/:id' => 'pagos#pagar', :via => :get, as: :pagar_venta

      match 'pagos/abonar/venta' => 'pagos#abonar', :via => :get, as: :abonar_venta

      match 'pagos/abonar/venta' => 'pagos#agregar_abono', :via => :post, as: :agregar_abono

      resources :alerta

      resources :tipo_productos

      resources :articulos

      resources :productos

      match 'venta/articulos' => 'venta#articulos', :via => :get, as: :articulos_venta

      match 'venta/articulos' => 'venta#articulos_credito', :via => :get, as: :articulos_credito

      match 'venta/creditos' => 'venta#credito', :via => :get, as: :credito

      match 'venta/creditos' => 'venta#seleccionar_cliente', :via => :post, as: :seleccionar_cliente

      match 'venta/articulos' => 'venta#agregar_articulos', :via => :post, as: :agregar_articulos

      get 'venta/:id/articulos/' => 'venta#venta_lista', as: :venta_lista

      # match 'venta/creditos' => 'venta#venta_lista_credito', :via => :post, as: :venta_lista_credito
      # get 'venta/:id/creditos/' => 'venta#venta_lista_credito', as: :venta_lista_credito

      get 'venta/cancelar' => 'venta#cancelar_venta', as: :cancelar_venta

      resources :venta

      resources :clientes

    end

    unauthenticated do
      root :to => 'devise/sessions#new', as: :unauthenticated_root
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
