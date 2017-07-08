class RequestController < ApplicationController
  def new
    session[:playlist_params] = playlist_params
  end

  def create
    request = Request.new(playlist_owner: User.find_by(uid: request_params[:playlist_owner]), 
                          request_from: current_user, 
                          playlist_name: request_params[:playlist_name], 
                          playlist_id: request_params[:playlist_id], 
                          song_id: request_params[:song_id], 
                          song_title: request_params[:song_title],
                          artist: request_params[:song_artist],
                          album: request_params[:song_album])

    if request.save
      redirect_to request_index_path
    end
    
  end

  def playlist_params
    params.permit(:playlist_id, :playlist_owner, :playlist_name)
  end

  def request_params
    params.permit(:song_id, :song_title, :song_artist, :song_album).merge(session[:playlist_params])
  end
end