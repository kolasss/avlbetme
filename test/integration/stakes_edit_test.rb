require 'test_helper'

class StakesEditTest < ActionDispatch::IntegrationTest

  def setup
    # initialize user session
    @depp = login_session(:depp)
    @bet = bets(:opened)
    @stake = @bet.stakes.first
  end

  test "unsuccessful edit" do
    @depp.get edit_bet_stake_path(@bet, @stake)
    @depp.assert_template 'stakes/edit'

    @depp.extend(StakeTestsConcern)
    @depp.valid_select_options

    @depp.patch bet_stake_path(@bet, @stake), stake: {
      bid: ""
    }

    @depp.assert_template 'stakes/edit'
    @depp.assert_select 'div.has-error'
  end

  test "successful edit" do
    new_bid = "new valid bid"
    new_objective = "new valid objective"
    @depp.patch bet_stake_path(@bet, @stake), stake: {
      bid: new_bid,
      objective: new_objective
    }

    @depp.assert_not @depp.flash.empty?
    @depp.assert_redirected_to @bet

    @stake.reload
    assert_equal @stake.bid,        new_bid
    assert_equal @stake.objective,  new_objective
  end
end
