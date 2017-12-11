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

  get 'static_pages/policy', to:'static_pages#policy'

  # api
  namespace :api, {format: :json } do
    get 'games', to: 'games#index'
    get 'categories', to: 'categories#index'
  end
  get 'games2', to: 'games#search'

end
