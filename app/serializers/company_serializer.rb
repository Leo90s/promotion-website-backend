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

class CompanySerializer < ActiveModel::Serializer
  attributes :id, :name, :address, :contact, :introduction, :image, :url
end
