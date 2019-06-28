# == Schema Information
#
# Table name: pictures
#
#  id         :bigint(8)        not null, primary key
#  file       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Picture < ApplicationRecord
  mount_uploader :file, AvatarUploader  

  validates_presence_of :file

  has_many :company_pictures
  has_many :companies, through: :company_pictures, source: :company
end
