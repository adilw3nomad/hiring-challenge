Rails.application.routes.draw do
  resources :backgrounds

  resources :categories, only: [:index, :show, :create, :update, :destroy]
end
