Karnl::Application.routes.draw do

  # This line mounts Spree's routes at the root of your application.
  # This means, any requests to URLs such as /products, will go to Spree::ProductsController.
  # If you would like to change where this engine is mounted, simply change the :at option to something different.
  #
  # We ask that you don't use the :as option here, as Spree relies on it being the default of "spree"
  root :to => "spree/products#index"

  Spree::Core::Engine.routes.prepend do
    namespace :admin do
      resources :brands
      resources :product_imports, :only => [:index, :new, :create]
    end
    resources :hearts
    resources :address_entries

    namespace :manage do
      resources :orders do
        resources :shipments do
          member do
            put :fire
          end
        end
      end
      match "/complete", to: "orders#complete", as: "complete"

      match "/", to: "orders#index"
      resources :address_entries
    end
  end
  mount Spree::Core::Engine, :at => '/'
end
