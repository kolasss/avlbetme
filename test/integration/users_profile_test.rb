require 'test_helper'

class UsersProfileTest < ActionDispatch::IntegrationTest

  test "profile display" do
    @user = users(:depp)

    get user_path(@user)
    assert_template 'users/show'
    assert_select 'h1', text: @user.name
    assert_select 'img.user_avatar'

    @user.friends_list.each do |friend|
      assert_match friend.name, response.body
    end

    @opened_bet = @user.bets.opened.first
    assert_select 'a', href: @opened_bet, text: @opened_bet.title
    @finished_bet = @user.bets.finished.first
    assert_select 'a', href: @finished_bet, text: @finished_bet.title
    @canceled_bet = @user.bets.canceled.first
    assert_select 'a', href: @canceled_bet, text: @canceled_bet.title

    @stake_won = @user.stakes.win.first
    assert_match @stake_won.objective, response.body

    @stake_lost = @user.stakes.lose.first
    assert_match @stake_lost.objective, response.body

    # TODO: тест статистики
  end
end
