class Playlist
  attr_reader :id, :name, :owner_id
  def initialize(attrs)
    @id = attrs['id']
    @name = attrs['name']
    @owner_id = attrs['owner']['id']
  end
end