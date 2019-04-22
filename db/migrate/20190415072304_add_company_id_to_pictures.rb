class AddCompanyIdToPictures < ActiveRecord::Migration[5.2]
  def change
    remove_reference :picture, :company, index: true
    add_reference :pictures, :company, index: true
  end
end
