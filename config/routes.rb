Rails.application.routes.draw do
  resources :categories
  resources :games
  devise_for :users, controllers: { :omniauth_callbacks => "omniauth_callbacks" }
  root to: 'home#index'
end
