Rails.application.routes.draw do
  resources :habits
  get 'favorites_habit/:habit_id', to: 'favorite_habits#add', as: 'add_favorite_habit'
  delete 'favorites_habit/:habit_id', to: 'favorite_habits#delete', as: 'delete_favorite_habit'

  get '/diaries/new/:habit_id', to: 'diaries#new', as: 'new_diary'
  resources :diaries, except: [:show, :new]
  get 'user/show'
  get 'user/log_in_guest'
  devise_for :users
  resources :users, only: [:show] do
    post 'follow', to: 'follows#create', as: 'create_follow'
    delete 'follow', to: 'follows#destroy', as: 'destroy_follow'
    get 'followings', to: 'people#followings', as: 'followings'
    get 'followers', to: 'people#followers', as: "followers"
  end
  get 'people', to: 'people#index', as: "people"
  root 'home#index'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
