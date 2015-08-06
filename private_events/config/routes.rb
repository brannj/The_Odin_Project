Rails.application.routes.draw do

  get 'sessions/new'

  root 'sessions#new'
  get 'signup' => 'users#new'
  get 'signin' => 'sessions#new'
  post 'signin' => 'sessions#create'
  delete 'signout' => 'sessions#destroy'
  resources :users, only: [:new, :create, :show]
end
