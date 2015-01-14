Rails.application.routes.draw do

	devise_for :users, :controllers => { :omniauth_callbacks => "omniauth_callbacks" } do
		post 'follow',   to: 'socializations#follow'
		post 'unfollow', to: 'socializations#unfollow'
	end

  get 'activities/index'

  resources :posts

	resources :profiles

	resources :tree_recipes

	resources :categories do
		post 'follow',   to: 'socializations#follow'
		post 'unfollow', to: 'socializations#unfollow'
	end

	resources :recipes do
		resources :reviews, except: [:show, :index]
	end

	root "recipes#index"

end
