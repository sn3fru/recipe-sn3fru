Rails.application.routes.draw do

  devise_for :users, :controllers => { :omniauth_callbacks => "omniauth_callbacks" }

  post '/users/:user_id/follow', to: 'socializations#follow', as: 'user_follow'
  post '/users/:user_id/unfollow', to: 'socializations#unfollow', as: 'user_unfollow'

  get 'activities/index'
  get 'mark_notifications_as_read/:activity_id', to: 'socializations#mark_notifications_as_read', as: 'mark_notifications_as_read'

  resources :posts

  resources :profiles

  resources :tree_recipes

  resources :categories do
    post 'follow',   to: 'socializations#follow'
    post 'unfollow', to: 'socializations#unfollow'
  end

  resources :recipes do
    resources :reviews, except: [:show, :index]
    post 'like',   to: 'socializations#recipe_like'
    post 'unlike', to: 'socializations#recipe_unlike'
  end

  resources :conversations, only: [:index, :show, :new, :create] do
    member do
      post :reply
      post :trash
      post :untrash
    end
  end

  get "sitemap.xml" => "home#sitemap", format: :xml, as: :sitemap
  get "robots.txt" => "home#robots", format: :text, as: :robots

  root "recipes#index"

end
