Rails.application.routes.draw do
  root 'posts#index'
  get     'login'  => 'sessions#new'
  post    'login'  => 'sessions#create'
  delete  'logout' => 'sessions#destroy'
  resources :users, only: [:show, :edit, :update, :destroy]
  resources :posts, only: [:new, :create, :index]
end
