class AddCompanyIdToPictures < ActiveRecord::Migration[5.2]
  def change
    add_reference :pictures, :company, index: true
  end
end
