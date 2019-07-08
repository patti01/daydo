Rails.application.routes.draw do
  get 'tasks/index'
  get 'tasks/create'
  get 'tasks/new'
  devise_for :users
  root to: 'tasks#index'

   resources :tasks, except: [:show]
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
