class CreatePictures < ActiveRecord::Migration[5.2]
  def change
    create_table :pictures do |t|
      t.string :file
      t.belongs_to :company, index: true

      t.timestamps
    end
  end
end
