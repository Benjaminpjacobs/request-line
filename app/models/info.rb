class Info
  attr_reader :name, :email, :id, :images, :href
  def initialize(attrs)
    @name = attrs['display_name']
    @email = attrs['email']
    @id = attrs['id']
    @images = attrs['images']
    @href = attrs['href']
  end
end