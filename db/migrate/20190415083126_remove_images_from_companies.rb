class RemoveImagesFromCompanies < ActiveRecord::Migration[5.2]
  def change
    remove_column :companies, :images, :text, array: true, default: []
  end
end
