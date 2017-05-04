Rails.application.routes.draw do

  resources :user_goals
  resources :goals
  post 'check', to: 'goals#check'
  root 'users#home'
  resources :users do
    post 'toggle_activity', on: :member
  end
  resource :session, only: [:new, :create, :destroy]

  get 'login', to: 'sessions#new'
  delete 'logout', to: 'sessions#destroy'

  get 'home', to: 'users#home'
end
