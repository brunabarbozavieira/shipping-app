Rails.application.routes.draw do
  root to: 'home#index'
  resources :vehicles, only: [:index, :new, :create, :show]
end
