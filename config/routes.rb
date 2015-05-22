Rails.application.routes.draw do
  root 'home#index'

  post "oauth/callback" => "oauths#callback"
  get "oauth/callback" => "oauths#callback" # for use with Github, Facebook
  get "oauth/:provider" => "oauths#oauth", :as => :auth_at_provider
  delete '/log_out', to: 'sessions#destroy', as: :log_out
  resources :users, only: [:index, :show, :destroy]

  resources :bets, except: [:index]
end
