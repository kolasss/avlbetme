require 'test_helper'

class BetsNewTest < ActionDispatch::IntegrationTest

  def setup
    # initialize user session
    @depp = login_session(:depp)
  end

  test "unsuccessful create" do
    @depp.get new_bet_path
    @depp.assert_template 'bets/new'

    assert_no_difference 'Bet.count' do
      @depp.post bets_path, bet: {
        title: "",
        body: "olololo"
      }
    end

    @depp.assert_template 'bets/new'
    @depp.assert_select 'div.has-error'
  end

  test "successful create" do
    @depp.get new_bet_path

    bet_title = "valid title"
    bet_body = 'olololo'
    assert_difference 'Bet.count', 1 do
      @depp.post bets_path, bet: {
        title: bet_title,
        body: bet_body
      }
    end
    current_user = @depp.assigns[:current_user]
    created_bet = @depp.assigns(:bet)

    assert current_user.bets.include? created_bet

    @depp.assert_not @depp.flash.empty?
    @depp.assert_redirected_to created_bet
    @depp.follow_redirect!
    @depp.assert_match bet_title, @depp.response.body
    @depp.assert_match bet_body, @depp.response.body
  end
end
