Rails.application.routes.draw do
  resources :usergroups_accesses

  resources :comments

  resources :photos

  resources :albums

  resources :user_usergroups

  resources :usergroups

  resources :owners

  get 'login' => "sessions#new", as: :login

  post 'login' => "sessions#create"

  get 'logout' => "sessions#destroy", as: :logout
  root 'sessions#new'
  mount RailsWatcher::Engine => "/rails_watcher"
end
