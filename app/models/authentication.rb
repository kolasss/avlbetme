# == Schema Information
#
# Table name: authentications
#
#  id         :integer          not null, primary key
#  user_id    :integer          not null
#  provider   :character varyin not null
#  uid        :character varyin not null
#  created_at :timestamp withou
#  updated_at :timestamp withou
#
# Indexes
#
#  index_authentications_on_provider_and_uid  (provider,uid)
#

class Authentication < ActiveRecord::Base
  belongs_to :user
end
