# == Schema Information
#
# Table name: companies
#
#  id           :bigint(8)        not null, primary key
#  address      :string
#  contact      :string
#  introduction :string
#  name         :string
#  url          :string
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#

class Company < ApplicationRecord
  has_many :company_pictures
  has_many :pictures, through: :company_pictures, source: :picture

  validates_presence_of :name, :contact, :address, :introduction, :url

  def self.search(search, params = nil, is_accurate = false)
    if !is_accurate
      if search.scan(/\S/).empty?
        where("array_to_string(code, ',') LIKE ?", "%#{search}%").where(params)
      else
        where("address LIKE ? or contact LIKE ? or introduction LIKE ? or name LIKE ? or url LIKE ?", 
              "%#{search}%", "%#{search}%", "%#{search}%", "%#{search}%", "%#{search}%")
      end
    else
      where('code @> ?', "{#{search}}").where(params)
    end
  end
end
