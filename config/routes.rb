Rails.application.routes.draw do
  get '/auth/spotify', as: :spotify_login
  get '/auth/spotify/callback', to: 'sessions#create'

  get '/login', to: 'sessions#new'
  delete '/logout', to: 'sessions#destroy'

  resources :dashboard, only: [:index]
end
