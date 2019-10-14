Rails.application.routes.draw do
  root 'application#hello'
  get 'home/index'

  devise_for :users, controllers: {
    registrations: 'users/registrations',
  }
end
