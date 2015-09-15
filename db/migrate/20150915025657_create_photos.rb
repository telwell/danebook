class CreatePhotos < ActiveRecord::Migration
  def change
    create_table :photos do |t|
			t.attachment :photo
			t.string :title
			t.string :description
			
      t.timestamps null: false
    end
  end
end
