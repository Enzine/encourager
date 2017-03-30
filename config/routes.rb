Rails.application.routes.draw do

  resources :user_goals
  resources :goals
  root 'users#index'
  resources :users

  resource :session, only: [:new, :create, :destroy]

  get 'login', to: 'sessions#new'
  delete 'logout', to: 'sessions#destroy'
end
