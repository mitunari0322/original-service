Rails.application.routes.draw do
  root to: "questions#index"
  
  get "login", to: "sessions#new"
  post "login", to: "sessions#create"
  delete "logout", to: "sessions#destroy"
  
  resources :users, only: [:new, :create, :show] do
    member do
      get :likes
      get :followings
      get :followers
    end
  end
  
  resources :questions, only: [:index, :new, :create, :show, :destroy]
  
  resources :answers, only: [:create, :destroy]
  
  resources :subjects, only: [:show]
  
  resources :favorites, only: [:create, :destroy]
  
  resources :relationships, only: [:create, :destroy]
end
