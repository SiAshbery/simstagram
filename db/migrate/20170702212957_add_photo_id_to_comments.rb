class AddPhotoIdToComments < ActiveRecord::Migration[5.1]
  def change
    add_column :comments, :photo_id, :integer
  end
end
