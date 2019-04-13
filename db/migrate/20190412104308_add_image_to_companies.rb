class AddImageToCompanies < ActiveRecord::Migration[5.2]
  def change
    add_column :companies, :image, :string
    add_column :companies, :url, :string
  end
end
