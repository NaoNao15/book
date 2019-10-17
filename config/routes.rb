Rails.application.routes.draw do
  root to: 'home#index'

  devise_for :users, controllers: {
    registrations: 'users/registrations',
  }
  resources :users, only: [:index, :show]
  resources :posts, only: [:new, :show, :create, :destroy]
end
