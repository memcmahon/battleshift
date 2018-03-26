Rails.application.routes.draw do
  root 'welcome#index'

  get "/register", to: 'users#new'
  post "/register", to: 'users#create'
  get "/dashboard", to: 'users#show'
  get "/activate/:activation_key", to: 'users#update'

  namespace :api do
    namespace :v1 do
      resources :games, only: [:show] do
        post "/shots", to: "games/shots#create"
      end
    end
  end
end
