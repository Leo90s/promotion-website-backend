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

class User < ApplicationRecord
  validates_presence_of :contact, :name
  validates_uniqueness_of :contact, :name

  has_secure_password
end
