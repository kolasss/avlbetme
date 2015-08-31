require 'test_helper'

class StakesNewTest < ActionDispatch::IntegrationTest

  def setup
    # initialize user session
    @depp = login_session(:depp)
    @bet = bets(:opened)
  end

  test "unsuccessful create" do
    @depp.get new_bet_stake_path(@bet)
    @depp.assert_template 'stakes/new'

    @depp.extend(CustomDsl)
    @depp.valid_select_options

    assert_no_difference 'Stake.count' do
      @depp.post bet_stakes_path(@bet), stake: {
        user_id: "",
        objective: "",
        stake_type_id: "",
        bid: ""
      }
    end

    @depp.assert_template 'stakes/new'
    @depp.assert_select 'div.has-error'
    @depp.valid_select_options
  end

  test "successful create" do
    @depp.get new_bet_stake_path(@bet)

    bet_new_user      = users(:ford)
    bet_user_id       = bet_new_user.id
    bet_objective     = "valid objective"
    bet_stake_type_id = StakeType.first.id
    bet_bid           = '425'

    assert_difference 'Stake.count', 1 do
      @depp.post bet_stakes_path(@bet), stake: {
        user_id: bet_user_id,
        objective: bet_objective,
        stake_type_id: bet_stake_type_id,
        bid: bet_bid
      }
    end

    assert @bet.users.include? bet_new_user
    @depp.assert_redirected_to @bet
    @depp.follow_redirect!
    @depp.assert_match bet_new_user.name, @depp.response.body
    @depp.assert_match bet_objective, @depp.response.body
    @depp.assert_match bet_bid, @depp.response.body
  end

  private

    module CustomDsl
      def valid_select_options
        current_user = assigns[:current_user]

        current_user.friends_list_with_self.each do |user|
          assert_select 'option', value: user.id
        end

        StakeType.all.each do |type|
          assert_select 'option', value: type.id
        end
      end
    end

end
