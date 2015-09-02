# == Schema Information
#
# Table name: stakes
#
#  id            :integer          not null, primary key
#  objective     :text
#  bid           :text             default("0"), not null
#  stake_type_id :integer
#  user_id       :integer
#  bet_id        :integer
#  status        :integer          default(0), not null
#  paid          :boolean          default(FALSE)
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#
# Indexes
#
#  index_stakes_on_bet_id         (bet_id)
#  index_stakes_on_stake_type_id  (stake_type_id)
#  index_stakes_on_user_id        (user_id)
#

require 'test_helper'

class StakeTest < ActiveSupport::TestCase
  def setup
    @stake = Stake.new(
      bid: "1000",
      stake_type_id: stake_types(:rub).id,
      user_id: users(:jolie).id,
      bet_id: bets(:finished).id,
      objective: 'Подтянуться 10 раз'
    )
  end

  test "should be valid" do
    assert @stake.valid?
  end

  test "title should be present" do
    @stake.bid = "     "
    assert_not @stake.valid?
  end

  test "stake_type should be present" do
    @stake.stake_type = nil
    assert_not @stake.valid?
  end

  test "user should be present" do
    @stake.user = nil
    assert_not @stake.valid?
  end

  test "bet should be present" do
    @stake.bet = nil
    assert_not @stake.valid?
  end

  test "stake should be uniq for user and bet" do
    @stake.bet = bets(:opened)
    assert_not @stake.valid?
  end

  test "status should be pass" do
    assert @stake.pass?
  end

  test "paid should be false" do
    assert_not @stake.paid?
  end

  test "method user_name should return correct value" do
    assert_equal @stake.user_name, @stake.user.name
  end

  test "method not_last? should return correct value" do
    one_depp = stakes(:one_depp)
    one_pit = stakes(:one_pit)

    assert one_depp.not_last?

    one_pit.destroy
    one_depp.reload
    assert_not one_depp.not_last?
  end
end
