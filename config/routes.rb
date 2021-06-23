Rails.application.routes.draw do
  devise_for :users
  root to: "prototypes#index"
  resources :prototypes do
    resources :comments, only: [:create, :destroy]
  end
  resources :comments, only: [:new, :create]
  resources :users, only: [:show]
end
