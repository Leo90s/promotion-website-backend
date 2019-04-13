# == Schema Information
#
# Table name: companies
#
#  id           :bigint(8)        not null, primary key
#  address      :string
#  contact      :string
#  image        :string
#  introduction :string
#  name         :string
#  url          :string
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#

class Company < ApplicationRecord
  mount_uploader :image, AvatarUploader

  validates_presence_of :name, :contact, :address, :introduction, :image, :url

  def self.search(search, params = nil, is_accurate = false)
    if !is_accurate
      if search.scan(/\D/).empty?
        where("array_to_string(code, ',') LIKE ?", "%#{search}%").where(params)
      else
        where("address LIKE ? or contact LIKE ? or introduction LIKE ? or name LIKE ?", 
              "%#{search}%", "%#{search}%", "%#{search}%", "%#{search}%")
      end
    else
      where('code @> ?', "{#{search}}").where(params)
    end
  end
end
