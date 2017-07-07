Rails.application.routes.draw do
  root to: 'dashboard#index'

  get '/login', to: 'sessions#new'
  delete '/logout', to: 'sessions#destroy'
 
  get '/auth/spotify', as: :spotify_login
  get '/auth/spotify/callback', to: 'sessions#create'

  resources :dashboard, only: [:index]

  namespace :song do
    get '/search', to: 'search#new'
  end

  namespace :playlist do
    get '/search', to: 'search#new'
  end
  
  
end
