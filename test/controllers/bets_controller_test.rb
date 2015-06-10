require 'test_helper'

class BetsControllerTest < ActionController::TestCase
  def setup
    @user       = users(:depp)
    @other_user = users(:pit)
    @admin_user = users(:jolie)
    @bet = bets(:opened_for_controller_test)
    @finish_results = {"#{@bet.stakes.first.id}" => "win"}
    @new_bet = { title: 'asdqwe' }
  end


  test "should get show" do
    get :show, id: @bet
    assert_response :success
  end

  test "should redirect new when not logged in" do
    get :new
    assert_redirected_to auth_at_provider_path(:provider => :vk)
  end

  test "should get new when logged in" do
    login_user @user
    get :new
    assert_response :success
  end

  test "should redirect create when not logged in" do
    post :create, bet: @new_bet
    assert_redirected_to auth_at_provider_path(:provider => :vk)
  end

  test "should create bet when logged in" do
    login_user @user
    assert_difference('Bet.count') do
      post :create, bet: @new_bet
    end
    assert_redirected_to assigns(:bet)
  end

  test "should redirect edit when not logged in" do
    get :edit, id: @bet
    assert_redirected_to root_url
  end

  test "should redirect edit when logged in as wrong user" do
    login_user @other_user
    get :edit, id: @bet
    assert_redirected_to root_url
  end

  test "should get edit when logged in as right user" do
    login_user @user
    get :edit, id: @bet
    assert_response :success
  end

  test "should get edit when logged in as admin" do
    login_user @admin_user
    get :edit, id: @bet
    assert_response :success
  end

  test "should redirect update when not logged in" do
    put :update, id: @bet, bet: @bet.attributes
    assert_redirected_to root_url
  end

  test "should redirect update when logged in as wrong user" do
    login_user @other_user
    put :update, id: @bet, bet: @bet.attributes
    assert_redirected_to root_url
  end

  test "should update bet when logged in as right user" do
    login_user @user
    put :update, id: @bet, bet: @bet.attributes
    assert_redirected_to @bet
  end

  test "should update bet when logged in as admin" do
    login_user @admin_user
    put :update, id: @bet, bet: @bet.attributes
    assert_redirected_to @bet
  end

  test "should redirect destroy when not logged in" do
    assert_no_difference 'Bet.count' do
      delete :destroy, id: @bet
    end
    assert_redirected_to root_url
  end

  test "should redirect destroy when logged in as wrong user" do
    login_user @other_user
    assert_no_difference 'Bet.count' do
      delete :destroy, id: @bet
    end
    assert_redirected_to root_url
  end

  test "should destroy bet when logged in as right user" do
    login_user @user
    assert_difference 'Bet.count', -1 do
      delete :destroy, id: @bet
    end
    assert_redirected_to root_url
  end

  test "should destroy bet when logged in as admin" do
    login_user @admin_user
    assert_difference 'Bet.count', -1 do
      delete :destroy, id: @bet
    end
    assert_redirected_to root_url
  end

  test "should redirect stop when not logged in" do
    get :stop, id: @bet
    assert_redirected_to root_url
  end

  test "should redirect stop when logged in as wrong user" do
    login_user @other_user
    get :stop, id: @bet
    assert_redirected_to root_url
  end

  test "should get stop when logged in as right user" do
    login_user @user
    get :stop, id: @bet
    assert_response :success
  end

  test "should get stop when logged in as admin" do
    login_user @admin_user
    get :stop, id: @bet
    assert_response :success
  end

  test "should redirect finish when not logged in" do
    post :finish, id: @bet, results: @finish_results
    assert_redirected_to root_url
  end

  test "should redirect finish when logged in as wrong user" do
    login_user @other_user
    post :finish, id: @bet, results: @finish_results
    assert_redirected_to root_url
  end

  test "should finish bet when logged in as right user" do
    login_user @user
    post :finish, id: @bet, results: @finish_results
    assert_redirected_to @bet
  end

  test "should finish bet when logged in as admin" do
    login_user @admin_user
    post :finish, id: @bet, results: @finish_results
    assert_redirected_to @bet
  end

  test "should redirect cancel when not logged in" do
    get :cancel, id: @bet
    assert_redirected_to root_url
  end

  test "should redirect cancel when logged in as wrong user" do
    login_user @other_user
    get :cancel, id: @bet
    assert_redirected_to root_url
  end

  test "should get cancel when logged in as right user" do
    login_user @user
    get :cancel, id: @bet
    assert_redirected_to @bet
  end

  test "should get cancel when logged in as admin" do
    login_user @admin_user
    get :cancel, id: @bet
    assert_redirected_to @bet
  end

end
