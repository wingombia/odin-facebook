Rails.application.routes.draw do
  devise_for :users
  resources :posts do
    resources :comments, except: [:index, :show, :new]
    resource :likes, only: [:create, :destroy]
  end
  resources :users, only: [:index, :show]
  resource :friendship, only: [:create, :destroy]

  root 'posts#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
