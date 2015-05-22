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

require 'test_helper'

class UserTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
