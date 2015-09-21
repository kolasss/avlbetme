Rails.application.routes.draw do
  root 'home#index'

  post "oauth/callback" => "oauths#callback"
  get "oauth/callback" => "oauths#callback" # for use with Github, Facebook
  get "oauth/:provider" => "oauths#oauth", as: :auth_at_provider
  delete '/log_out', to: 'sessions#destroy', as: :log_out
  resources :users, only: [:index, :show, :destroy]
  get '3770abc2f3d1f90bef6b7e010d153fd2d8f' => 'users#krytoi'

  resources :bets, except: [:index] do
    member do
      get :stop
      post :finish
      get :cancel
      get :activities
    end
    resources :stakes, except: [:index, :show]
  end

  resources :stake_types, except: [:show]
end
