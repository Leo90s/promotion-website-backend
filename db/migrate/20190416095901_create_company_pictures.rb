class CreateCompanyPictures < ActiveRecord::Migration[5.2]
  def change
    create_table :company_pictures do |t|
      t.belongs_to :company, index: true
      t.belongs_to :picture, index: true

      t.timestamps
    end
  end
end
