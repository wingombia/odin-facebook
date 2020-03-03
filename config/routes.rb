Rails.application.routes.draw do
  devise_for :users
  resources :posts do
    resources :comments, except: [:index, :show, :new]
    resource :likes, only: [:create, :destroy]
  end
  resources :users, only: [:index, :show]
  resource :friendship, only: [:create, :destroy]
  scope :api, default: { format: :json } do
    devise_scope :user do
      post 'users/login', to: 'sessions#create' , as: 'api_login'
    end
    post 'users'      , to: 'api_users#create', as: 'api_register'
    get  'user'       , to: 'api_users#show'  , as: 'api_show_user' 
    put  'user'       , to: 'api_users#update', as: 'api_update_user'
    scope :profile, default: { format: :json } do
      get ':username'            , to: 'api_user#show_profile', as: 'api_show_profile'
      post ':username/befriend'  , to: 'api_user#befriend'    , as: 'api_befriend'
      delete ':username/unfriend', to: 'api_user#unfriend'    , as: 'api_unfriend'
    end 
  end
  root 'posts#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
