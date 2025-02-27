Rails.application.routes.draw do
  resources :memberships, only: [ :index, :show, :create, :update, :destroy ]
  resources :clients, only: [ :index, :show, :create, :update, :destroy ]
  resources :gyms, only: [ :index, :show, :create, :update, :destroy ]
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
