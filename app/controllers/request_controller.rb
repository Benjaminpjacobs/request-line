class RequestController < ApplicationController
  before_action :set_request, only: [:update]
  def new
    session[:playlist_params] = playlist_params
  end

  def create
    request = Request.new(
                          playlist_owner: User.find_by(uid: request_params[:playlist_owner]), 
                          request_from: current_user, 
                          playlist_name: request_params[:playlist_name], 
                          playlist_id: request_params[:playlist_id], 
                          song_id: request_params[:song_id], 
                          song_title: request_params[:song_title],
                          artist: request_params[:song_artist],
                          album: request_params[:song_album]
                          )

    if request.save
      redirect_to request_index_path
    else
      redirect_to dashboard_index_path
      flash[:error] = "That Spotify User is not in our system. Please invite them to join!"
    end
    
  end


  def update
    response = @request.send(params[:update_action].to_sym, current_user)
    redirect_to request_index_path
  end
  
  private

    def set_request
      @request = Request.find(params[:id])
    end

    def playlist_params
      params.permit(:playlist_id, :playlist_owner, :playlist_name)
    end

    def request_params
      params.permit(:song_id, :song_title, :song_artist, :song_album).merge(session[:playlist_params])
    end
end