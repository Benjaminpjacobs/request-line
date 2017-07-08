class Request < ApplicationRecord
  belongs_to :request_from, :class_name => 'User'
  belongs_to :playlist_owner, :class_name => 'User'
  
  enum status: { 'Open'=> 0, 'Approved'=> 1, 'Denied' => 2, 'Cancelled' => 3}
end
