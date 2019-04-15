# == Schema Information
#
# Table name: users
#
#  id              :bigint(8)        not null, primary key
#  account         :string
#  name            :string
#  password_digest :string
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#

class UserSerializer < ActiveModel::Serializer
  attributes :id, :account, :name
end
