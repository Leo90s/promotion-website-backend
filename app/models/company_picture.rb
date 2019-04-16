# == Schema Information
#
# Table name: company_pictures
#
#  id         :bigint(8)        not null, primary key
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  company_id :bigint(8)
#  picture_id :bigint(8)
#
# Indexes
#
#  index_company_pictures_on_company_id  (company_id)
#  index_company_pictures_on_picture_id  (picture_id)
#

class CompanyPicture < ApplicationRecord
  belongs_to :company
  belongs_to :picture

  validates_presence_of :company, :picture
end
