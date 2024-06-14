Rails.application.routes.draw do
  resources :habits
  get 'user/show'
  get 'user/log_in_guest'
  devise_for :users
  
  namespace :users do
    resource :follows, only: [:create, :destroy] 
    get 'followings', to: 'follows#followings', as: 'followings'
    get 'followers', to: 'follows#followers', as: "followers"
  end
  root 'home#index'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
