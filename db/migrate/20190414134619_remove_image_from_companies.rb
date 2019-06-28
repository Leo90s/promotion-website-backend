class RemoveImageFromCompanies < ActiveRecord::Migration[5.2]
  def change
    add_column :companies, :images, :text, array: true, default: []
  end
end
