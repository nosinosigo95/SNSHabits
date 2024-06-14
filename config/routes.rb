Rails.application.routes.draw do
  resources :habits
  get 'user/show'
  get 'user/log_in_guest'
  devise_for :users
  
  namespace :users do
    post ':user_id/follow', to: 'follows#create', as: 'create_follow'
    delete ':user_id/follow', to: 'follows#destroy', as: 'destroy_follow'
    get ':user_id/followings', to: 'follows#followings', as: 'followings'
    get ':user_id/followers', to: 'follows#followers', as: "followers"
  end
  root 'home#index'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
