Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root to: "homes#top"
  resources :books#, only: [:new, :create, :index, :show, :edit, :destroy]
  resources :users, only: [:show, :edit, :index, :update]
  get 'home/about', to: 'homes#about', as: 'about'
  #get 'users', to: 'users#index', as: 'index_users'
  #get 'books', to: 'books#index', as: 'index_books'
  
  devise_scope :user do
    post "users/guest_sign_in", to: "users/sessions#guest_sign_in"
  end
  
  resources :notifications, only: [:update]
end
