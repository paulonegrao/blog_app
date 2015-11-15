Rails.application.routes.draw do

  root "home#index"
  get "/about"                  => "home#about", as: :about_home

  resources :posts do
    resources :comments, only: [:new, :create, :edit, :update, :destroy]

    resources :likes, only: [:create, :destroy]
  end

  resources :users, only: [:new, :create]

  resources :sessions, only: [:new, :create, :destroy] do
    delete :destroy, on: :collection
  end


end
