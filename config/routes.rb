Rails.application.routes.draw do

  root "home#index"
  get "/about"                  => "home#about", as: :about_home

  match "/delayed_job" => DelayedJobWeb, :anchor => false, via: [:get, :post]

  resources :posts do
    resources :comments, only: [:new, :create, :edit, :update, :destroy]

    resources :likes, only: [:create, :destroy]
  end

  resources :users, only: [:new, :create]

  resources :sessions, only: [:new, :create, :destroy] do
    delete :destroy, on: :collection
  end

  resources :categories do
    resources :posts, only: [:index, :show]
  end


end
