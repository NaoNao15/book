Rails.application.routes.draw do
  root to: 'home#index'

  devise_for :users, controllers: {
    registrations: 'users/registrations',
  }
  resources :users do
    member do
      get :following, :followers
    end
  end
  resources :users, only: [:index, :show]
  resources :posts, only: [:new, :show, :create, :destroy]
  resources :relationships, only: [:create, :destroy]
end
