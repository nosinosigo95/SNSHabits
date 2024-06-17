Rails.application.routes.draw do
  resources :habits
  get '/diaries/new/:habit_id', to: 'diaries#new', as: 'new_diary' 
  resources :diaries, except: [:index, :new]
  get 'user/show'
  get 'user/log_in_guest'
  devise_for :users
  resources :users, only:[:show] do
    post 'follow', to: 'follows#create', as: 'create_follow'
    delete 'follow', to: 'follows#destroy', as: 'destroy_follow'
    get 'followings', to: 'follows#followings', as: 'followings'
    get 'followers', to: 'follows#followers', as: "followers"
  end

  root 'home#index'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
