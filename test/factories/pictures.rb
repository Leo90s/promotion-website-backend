# == Schema Information
#
# Table name: pictures
#
#  id         :bigint(8)        not null, primary key
#  file       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  company_id :bigint(8)
#
# Indexes
#
#  index_pictures_on_company_id  (company_id)
#

FactoryBot.define do
  factory :picture do
    file { "MyString" }
  end
end
