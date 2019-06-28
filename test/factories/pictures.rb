# == Schema Information
#
# Table name: pictures
#
#  id         :bigint(8)        not null, primary key
#  file       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

FactoryBot.define do
  factory :picture do
    file { "MyString" }
  end
end
