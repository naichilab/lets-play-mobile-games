Rails.application.routes.draw do
  resources :categories
  resources :games
  devise_for :users, controllers: {
      :omniauth_callbacks => "omniauth_callbacks",
      sessions: "users/sessions",
      registrations: "users/registrations",
      passwords: "users/passwords"
  }
  root to: 'home#index'
end
