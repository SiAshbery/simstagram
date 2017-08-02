Rails.application.routes.draw do

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :photos do
    resources :comments, only: [:new, :create, :destroy, :edit, :update]
    resources :likes, only: [:new, :create, :destroy]
  end

  root 'photos#index'

  get  '/session/new' => 'sessions#new'
  post '/session/new' => 'sessions#create'
  get  '/session/destroy' => 'sessions#destroy'

  resources :users

end
