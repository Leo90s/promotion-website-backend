class AddOriginalFilenameToPictures < ActiveRecord::Migration[5.2]
  def change
    add_column :pictures, :original_filename, :string
    add_column :pictures, :content_type, :string
  end
end
