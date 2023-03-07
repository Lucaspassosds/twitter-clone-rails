require 'sidekiq/web'

Rails.application.routes.draw do
  authenticate :user, lambda { |u| u.admin? } do
    mount Sidekiq::Web => '/sidekiq'
  end

  resources :tweets, except: [:edit, :update] do
    resources :comments, only: [:create, :destroy]
    member do
      post :retweet
    end
  end

  resources :profiles do
    collection do
      post 'follow/:id' => :follow, as: 'follow'
      post 'unfollow/:id' => :unfollow, as: 'unfollow'
    end
  end

  resources :likes, only: :create

  devise_for :users
  root to: "tweets#index"
end
