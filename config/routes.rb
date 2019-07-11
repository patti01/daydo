Rails.application.routes.draw do
  get 'comments/new'
  devise_for :users, :controllers => { :omniauth_callbacks => "users/omniauth_callbacks" }
  root to: 'tasks#index'

  resources :tasks do
    resources :comments, only: [ :show, :create ]
  end
  resources :comments, only: [ :destroy ]
end
