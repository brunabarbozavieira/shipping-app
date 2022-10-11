Rails.application.routes.draw do
  devise_for :users
  root to: 'home#index'
  resources :vehicles, only: [:index, :new, :create, :show, :edit, :update]
  resources :shipping_methods, only: [:index, :new, :create, :show, :update, :edit]
  resources :price_by_weights, only: [:index, :new, :create, :update, :edit]
  resources :price_by_distances, only: [:index, :new, :create, :update, :edit]
end
