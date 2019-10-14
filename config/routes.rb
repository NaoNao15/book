Rails.application.routes.draw do
  root 'application#hello'

  devise_for :users, controllers: {
    registrations: 'users/registrations',
  }
end
