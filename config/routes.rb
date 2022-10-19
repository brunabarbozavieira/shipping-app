Rails.application.routes.draw do
  devise_for :users
  root to: 'home#index'
  resources :vehicles, only: [:index, :new, :create, :show, :edit, :update] do 
    post 'maintenance', on: :member
    post 'available', on: :member
    get 'search', on: :collection
  end
  resources :shipping_methods, only: [:index, :new, :create, :show, :update, :edit] do 
    post 'active', on: :member
    post 'disabled', on: :member
  end
  resources :price_by_weights, only: [:index, :new, :create, :update, :edit]
  resources :price_by_distances, only: [:index, :new, :create, :update, :edit]
  resources :delivery_times, only: [:index, :new, :create, :update, :edit]
  resources :service_orders, only: [:index, :new, :create, :show] do
    patch 'start_service_order'
    get 'search', on: :collection
  end
end
