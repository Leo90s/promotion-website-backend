class RemoveImageFromCompanies < ActiveRecord::Migration[5.2]
  def change
    remove_column :companies, :images, :json
    add_column :companies, :images, :text, array: true, default: []
  end
end
