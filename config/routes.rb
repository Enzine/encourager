Rails.application.routes.draw do

  resources :user_goals
  resources :goals
  root 'users#index'
  resources :users
end
