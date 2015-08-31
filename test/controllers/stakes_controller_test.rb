require 'test_helper'

class StakesControllerTest < ActionController::TestCase
  def setup
    @user       = users(:depp)
    @other_user = users(:pit)
    @admin_user = users(:jolie)
    @bet = bets(:opened_for_controller_test)
    @stake = stakes(:three_depp)

    @new_stake = {
      objective: 'dsfsd',
      bid: 1000,
      stake_type_id: stake_types(:rub),
      user_id: @other_user
    }
  end


  test "should redirect new when not logged in" do
    get :new, bet_id: @bet
    assert_redirected_to root_url
  end

  test "should get new when logged in as wrong user" do
    login_user @other_user
    get :new, bet_id: @bet
    assert_redirected_to root_url
  end

  test "should get new when logged in as right user" do
    login_user @user
    get :new, bet_id: @bet
    assert_response :success
  end

  test "should get new when logged in as admin" do
    login_user @admin_user
    get :new, bet_id: @bet
    assert_response :success
  end

  test "should redirect create when not logged in" do
    post :create, bet_id: @bet, :stake => @new_stake
    assert_redirected_to root_url
  end

  test "should redirect create when logged in as wrong user" do
    login_user @other_user
    post :create, bet_id: @bet, :stake => @new_stake
    assert_redirected_to root_url
  end

  test "should create stake when logged in as right user" do
    login_user @user
    assert_difference('Stake.count') do
      post :create, bet_id: @bet, :stake => @new_stake
    end
    assert_redirected_to @bet
  end

  test "should create stake when logged in as admin" do
    login_user @admin_user
    assert_difference('Stake.count') do
      post :create, bet_id: @bet, :stake => @new_stake
    end
    assert_redirected_to @bet
  end

  test "should redirect edit when not logged in" do
    get :edit, bet_id: @bet, id: @stake
    assert_redirected_to root_url
  end

  test "should redirect edit when logged in as wrong user" do
    login_user @other_user
    get :edit, bet_id: @bet, id: @stake
    assert_redirected_to root_url
  end

  test "should get edit when logged in as right user" do
    login_user @user
    get :edit, bet_id: @bet, id: @stake
    assert_response :success
  end

  test "should get edit when logged in as admin" do
    login_user @admin_user
    get :edit, bet_id: @bet, id: @stake
    assert_response :success
  end

  test "should redirect update when not logged in" do
    put :update, bet_id: @bet, id: @stake, stake: @stake.attributes
    assert_redirected_to root_url
  end

  test "should redirect update when logged in as wrong user" do
    login_user @other_user
    put :update, bet_id: @bet, id: @stake, stake: @stake.attributes
    assert_redirected_to root_url
  end

  test "should update stake when logged in as right user" do
    login_user @user
    put :update, bet_id: @bet, id: @stake, stake: @stake.attributes
    assert_redirected_to @bet
  end

  test "should update stake when logged in as admin" do
    login_user @admin_user
    put :update, bet_id: @bet, id: @stake, stake: @stake.attributes
    assert_redirected_to @bet
  end

  test "should redirect destroy when not logged in" do
    assert_no_difference 'Stake.count' do
      delete :destroy, bet_id: @bet, id: @stake
    end
    assert_redirected_to root_url
  end

  test "should redirect destroy when logged in as wrong user" do
    login_user @other_user
    assert_no_difference 'Stake.count' do
      delete :destroy, bet_id: @bet, id: @stake
    end
    assert_redirected_to root_url
  end

  test "should destroy stake when logged in as right user" do
    login_user @user
    assert_difference 'Stake.count', -1 do
      delete :destroy, bet_id: @bet, id: @stake
    end
    assert_redirected_to @bet
  end

  test "should destroy stake when logged in as admin" do
    login_user @admin_user
    assert_difference 'Stake.count', -1 do
      delete :destroy, bet_id: @bet, id: @stake
    end
    assert_redirected_to @bet
  end

  test "should not destroy single stake" do
    login_user @user
    bet = bets(:single_stake)
    stake = bet.stakes.first

    assert_no_difference 'Stake.count' do
      delete :destroy, bet_id: bet, id: stake
    end
    assert_redirected_to bet
  end

end
