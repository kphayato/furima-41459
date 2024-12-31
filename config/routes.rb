Rails.application.routes.draw do
  devise_for :users

  root "items#index"
  
  # productsリソースにネストされたordersリソース
  resources :products do
    resources :orders, only: [:index, :create]
  end
end