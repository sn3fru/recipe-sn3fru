Rails.application.routes.draw do
	
	devise_for :users
	
	resources :recipes do
		resources :reviews, except: [:show, :index]
	end


	root "recipes#index"
	
end
