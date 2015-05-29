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
#  friends                      :jsonb            default({}), not null
#
# Indexes
#
#  index_users_on_friends            (friends)
#  index_users_on_remember_me_token  (remember_me_token)
#

require 'test_helper'

class UserTest < ActiveSupport::TestCase
  def setup
    @user = User.new(
      name: "Николай Аммосов",
      photo: "http://cs623631.vk.me/v623631476/1cbe5/xovD7YVxZKU.jpg",
      friends: {"vk_friends_ids"=>[54304, 95663]}
    )
    @vk_authentication = @user.authentications.build(
      provider: 'vk',
      uid: '3750476'
    )
  end

  test "should be valid" do
    assert @user.valid?
  end

  test "name should be present" do
    @user.name = "     "
    assert_not @user.valid?
  end

  test "should have authentication" do
    assert @user.authentications.any?
  end

  test "method vk_id should match authentication uid" do
    @user.save
    @vk_authentication.save
    assert_equal @user.vk_id, @vk_authentication.uid
  end

  test "associated authentications should be destroyed" do
    @user.save
    @vk_authentication.save
    assert_difference 'Authentication.count', -1 do
      @user.destroy
    end
  end

  test "method friends_list should return right users" do
    depp = users(:depp)
    pit = users(:pit)
    jolie = users(:jolie)

    assert depp.friends_list.include?(pit)
    assert_not depp.friends_list.include?(jolie)
  end

  test "should not allow destroy with exist stake" do
    @user.save
    @user.stakes.create(
      stake_type_id: 1,
      bet_id: 1,
      bid: 'test'
    )
    assert_not @user.destroy
  end

  test "should have bets" do
    depp = users(:depp)
    bet = bets(:finished)

    assert depp.bets.include? bet
  end
end
