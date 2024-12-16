Rails.application.routes.draw do
  devise_for :users

  root "items#index"
  resources :items, only: [:index, :new, :create, :show, :edit]
  resources :orders, only: [:new, :create]
end

