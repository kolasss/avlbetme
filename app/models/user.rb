# == Schema Information
#
# Table name: users
#
#  id                           :integer          not null, primary key
#  name                         :character varyin not null
#  photo                        :character varyin
#  created_at                   :timestamp withou
#  updated_at                   :timestamp withou
#  remember_me_token            :character varyin
#  remember_me_token_expires_at :timestamp withou
#
# Indexes
#
#  index_users_on_remember_me_token  (remember_me_token)
#

class User < ActiveRecord::Base
  authenticates_with_sorcery!

  # authenticates_with_sorcery! do |config|
  #   config.authentications_class = Authentication
  # end

  has_many :authentications, :dependent => :destroy
  accepts_nested_attributes_for :authentications
end
