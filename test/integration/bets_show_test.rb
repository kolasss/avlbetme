require 'test_helper'

class BetShowTest < ActionDispatch::IntegrationTest

  def setup
    @bet = bets(:finished)
    @stake = @bet.stakes.first
  end

  test "bet buttons for guest" do
    get bet_path(@bet)
    assert_template 'bets/show'
    assert_select 'a[href=?]',
      bet_path(@bet),
      text: @bet.title
    assert_select 'a[href=?]', edit_bet_path(@bet), false
    assert_select 'a[href=?]', stop_bet_path(@bet), false
    assert_select 'a[href=?]', cancel_bet_path(@bet), false
    assert_select 'a[href=?]',
      bet_path(@bet),
      text: /Удалить/,
      count: 0
    assert_select 'a[href=?]', new_bet_stake_path(@bet), false

    assert_select 'a[href=?]', edit_bet_stake_path(@bet, @stake), false
    assert_select 'a[href=?]',
      bet_stake_path(@bet, @stake),
      html: /fa-trash/,
      count: 0
  end

  test "bet buttons for user" do
    depp = login_session(:depp)
    depp.extend(CustomDsl)
    depp.test_buttons_for_authorized_user
  end

  test "bet buttons for admin" do
    jolie = login_session(:jolie)
    jolie.extend(CustomDsl)
    jolie.test_buttons_for_authorized_user
  end

  private

    module CustomDsl
      def test_buttons_for_authorized_user
        get bet_path(@bet)
        assert_select 'a[href=?]', edit_bet_path(@bet)
        assert_select 'a[href=?]', stop_bet_path(@bet)
        assert_select 'a[href=?]', cancel_bet_path(@bet)
        assert_select 'a[href=?]',
          bet_path(@bet),
          text: /Удалить/
        assert_select 'a[href=?]', new_bet_stake_path(@bet)

        assert_select 'a[href=?]', edit_bet_stake_path(@bet, @stake)
        assert_select 'a[href=?]',
          bet_stake_path(@bet, @stake),
          html: /fa-trash/
      end
    end
end
