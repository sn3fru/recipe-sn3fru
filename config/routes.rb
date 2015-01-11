Rails.application.routes.draw do
	
	resources :profiles

	resources :tree_recipes

	resources :categories do
		post 'follow',   to: 'socializations#follow'
		post 'unfollow', to: 'socializations#unfollow'
	end


	devise_for :users do
		post 'follow',   to: 'socializations#follow'
		post 'unfollow', to: 'socializations#unfollow'
	end

	
	resources :recipes do
		resources :reviews, except: [:show, :index]
	end

	root "recipes#index"
	
end
