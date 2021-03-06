Rails.application.routes.draw do
  resources :store_urls
  resources :platforms
  resources :categories
  resources :games

  devise_for :users, controllers: {
      :omniauth_callbacks => "omniauth_callbacks",
      sessions: "users/sessions",
      registrations: "users/registrations",
      passwords: "users/passwords"
  }
  root to: 'home#index'

  devise_scope :user do
    get "users/games", to: "users/registrations#games"
  end

  # api
  namespace :api, {format: :json } do
    get 'games', to: 'games#index'
    get 'platforms', to: 'platforms#index'
    get 'categories', to: 'categories#index'
  end

end
