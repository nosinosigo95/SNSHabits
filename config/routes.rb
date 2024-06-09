Rails.application.routes.draw do
  get 'habits/new'
  post 'habits/create'
  get 'user/show'
  get 'user/log_in_guest'
  devise_for :users
  root 'home#index'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
