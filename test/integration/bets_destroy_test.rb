require 'test_helper'

class BetsDestroyTest < ActionDispatch::IntegrationTest

  def setup
    @bet = bets(:opened)
  end

  test "unsuccessful destroy" do
    # not logged in
    assert_no_difference 'Bet.count' do
      delete bet_path(@bet)
    end
  end

  test "successful destroy" do
    @depp = login_session(:depp)
    assert_difference 'Bet.count', -1 do
      @depp.delete bet_path(@bet)
    end
  end

end
