class RequestController < ApplicationController
  def new
    session[:request_params] = request_params
  end

  def create
    binding.pry
  end

  def request_params
    params.permit(:playlist_id, :playlist_owner)
  end
end