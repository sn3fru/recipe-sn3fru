Rails.application.routes.draw do
  resources :reviews

  devise_for :users
 resources :recipes

 root "recipes#index"
end
