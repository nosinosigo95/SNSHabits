Rails.application.routes.draw do
  get 'chat/create'
  resources :habits
  get 'favorites_habit/:habit_id', to: 'favorite_habits#add', as: 'add_favorite_habit'
  delete 'favorites_habit/:habit_id', to: 'favorite_habits#delete', as: 'delete_favorite_habit'
  get 'continuation_habit/:habit_id', to: 'continuation#add', as: 'add_continuation'
  delete 'continuation_habit/:habit_id', to: 'continuation#delete', as: 'delete_continuation'
  get '/diaries/new/:habit_id', to: 'diaries#new', as: 'new_diary'
  resources :diaries, except: [:show, :new]
  get 'user/log_in_guest', to: 'users#log_in_guest', as: 'log_in_guest'
  devise_for :users
  resources :users, only: [:show] do
    post 'follow', to: 'users#create', as: 'create_follow'
    delete 'follow', to: 'users#destroy', as: 'destroy_follow'
    get 'followings', to: 'users#followings', as: 'followings'
    get 'followers', to: 'users#followers', as: "followers"
    get 'favorite', to: 'users#show_favorite_habits', as: "show_favorite"
  end
  get 'people', to: 'users#index', as: "people"
  root 'home#index'

  resources :chat, only: [:create]
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
