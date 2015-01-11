Rails.application.routes.draw do
	
  resources :profiles

  resources :tree_recipes

  resources :categories

	devise_for :users
	
	resources :recipes do
		resources :reviews, except: [:show, :index]
	end


	root "recipes#index"
	
end
