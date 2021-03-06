# == Schema Information
#
# Table name: stake_types
#
#  id         :integer          not null, primary key
#  title      :string           not null
#  numeric    :boolean          default(FALSE)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'test_helper'

class StakeTypeTest < ActiveSupport::TestCase
  def setup
    @stake_type = StakeType.new(
      title: "Доллар"
    )
  end

  test "should be valid" do
    assert @stake_type.valid?
  end

  test "title should be present" do
    @stake_type.title = "     "
    assert_not @stake_type.valid?
  end

  test "numeric should be false" do
    assert_not @stake_type.numeric?
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
