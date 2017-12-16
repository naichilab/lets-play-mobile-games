Rails.application.routes.draw do
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



  # api
  namespace :api, {format: :json } do
    get 'games', to: 'games#index'
    get 'categories', to: 'categories#index'
  end

end
