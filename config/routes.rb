Rails.application.routes.draw do
  get '/auth/spotify', as: :spotify_login
  get '/auth/spotify/callback', to: 'sessions#create'

  get '/login', to: 'sessions#new'
  delete '/logout', to: 'sessions#destroy'

  get '/song-search', to: 'song_search#new'
  get '/playlist-search', to: 'playlist_search#new'
  
  resources :dashboard, only: [:index]
end
