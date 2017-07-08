class CreateRequests < ActiveRecord::Migration[5.0]
  def change
    create_table :requests do |t|
      t.integer :playlist_owner_id, foreign_key: true
      t.integer :request_from_id, foreign_key: true
      t.string :song_id
      t.string :song_title
      t.string :artist
      t.string :album
      t.string :playlist_id
      t.string :playlist_name
      t.integer :status, default: 0
    end
  end
end
