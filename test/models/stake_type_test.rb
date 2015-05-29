# == Schema Information
#
# Table name: stake_types
#
#  id         :integer          not null, primary key
#  title      :character varyin not null
#  numeric    :boolean          default(FALSE)
#  created_at :timestamp withou not null
#  updated_at :timestamp withou not null
#

require 'test_helper'

class StakeTypeTest < ActiveSupport::TestCase
  def setup
    @stake_type = StakeType.new(
      title: "Доллар",
      numeric: true
    )
  end

  test "should be valid" do
    assert @stake_type.valid?
  end

  test "title should be present" do
    @stake_type.title = "     "
    assert_not @stake_type.valid?
  end

  test "should not allow destroy with exist stake" do
    @stake_type.save
    @stake_type.stakes.create(
      user_id: 1,
      bet_id: 1,
      bid: 'test'
    )
    assert_not @stake_type.destroy
  end
end
