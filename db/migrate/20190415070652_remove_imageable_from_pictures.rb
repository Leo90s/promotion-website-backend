class RemoveImageableFromPictures < ActiveRecord::Migration[5.2]
  def change
    remove_reference :pictures, :imageable, polymorphic: true, index: true
    remove_column :pictures, :content_type, :string
    remove_column :pictures, :original_filename, :string
  end
end
