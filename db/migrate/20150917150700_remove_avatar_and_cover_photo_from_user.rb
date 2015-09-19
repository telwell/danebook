class RemoveAvatarAndCoverPhotoFromUser < ActiveRecord::Migration
  def change
  	remove_attachment :users, :avatar
  	remove_attachment :users, :cover_photo
  	add_column :users, :avatar_id, :integer
  	add_column :users, :cover_photo_id, :integer
  end
end
