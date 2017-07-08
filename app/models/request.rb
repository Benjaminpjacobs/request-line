class Request < ApplicationRecord
  belongs_to :request_from, :class_name => 'User'
  belongs_to :playlist_owner, :class_name => 'User'
  
  enum status: { 'Open'=> 0, 'Approved'=> 1, 'Denied' => 2, 'Cancelled' => 3}

  def approve(user)
    response = SpotifyService.update_playlist(self, user)
    if response == 'Created'
      self.status = 1
      self.save
    end
    response
  end

  def deny(user)
    self.status = 2
    self.save
  end
end

