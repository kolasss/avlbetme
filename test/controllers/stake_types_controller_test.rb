require 'test_helper'

class StakeTypesControllerTest < ActionController::TestCase

  def setup
    @user       = users(:depp)
    @admin_user = users(:jolie)
    @stake_type = stake_types(:rub)
  end

  test "should redirect index when not logged in" do
    get :index
    assert_redirected_to root_url
  end

  test "should redirect index when logged in as a non-admin" do
    login_user @user
    get :index
    assert_redirected_to root_url
  end

  test "should get index when logged in as admin" do
    login_user @admin_user
    get :index
    assert_response :success
  end

  test "should redirect new when not logged in" do
    get :new
    assert_redirected_to root_url
  end

  test "should redirect new when logged in as a non-admin" do
    login_user @user
    get :new
    assert_redirected_to root_url
  end

  test "should get new when logged in as admin" do
    login_user @admin_user
    get :new
    assert_response :success
  end

  test "should redirect create when not logged in" do
    post :create, :stake_type => {
      :title => "asd",
      :numeric => "true"
    }
    assert_redirected_to root_url
  end

  test "should redirect create when logged in as a non-admin" do
    login_user @user
    post :create, :stake_type => {
      :title => "asd",
      :numeric => "true"
    }
    assert_redirected_to root_url
  end

  test "should create stake type when logged in as admin" do
    login_user @admin_user
    assert_difference('StakeType.count') do
      post :create, :stake_type => {
        :title => "asd",
        :numeric => "true"
      }
    end
    assert_redirected_to stake_types_path
  end

  test "should redirect edit when not logged in" do
    get :edit, id: @stake_type
    assert_redirected_to root_url
  end

  test "should redirect edit when logged in as a non-admin" do
    login_user @user
    get :edit, id: @stake_type
    assert_redirected_to root_url
  end

  test "should get edit when logged in as admin" do
    login_user @admin_user
    get :edit, id: @stake_type
    assert_response :success
  end

  test "should redirect update when not logged in" do
    put :update, id: @stake_type, stake_type: @stake_type.attributes
    assert_redirected_to root_url
  end

  test "should redirect update when logged in as a non-admin" do
    login_user @user
    put :update, id: @stake_type, stake_type: @stake_type.attributes
    assert_redirected_to root_url
  end

  test "should update stake type when logged in as admin" do
    login_user @admin_user
    put :update, id: @stake_type, stake_type: @stake_type.attributes
    assert_redirected_to stake_types_path
  end

  test "should redirect destroy when not logged in" do
    assert_no_difference 'StakeType.count' do
      delete :destroy, id: @stake_type
    end
    assert_redirected_to root_url
  end

  test "should redirect destroy when logged in as a non-admin" do
    login_user @user
    assert_no_difference 'StakeType.count' do
      delete :destroy, id: @stake_type
    end
    assert_redirected_to root_url
  end

  test "should destroy stake type when logged in as admin" do
    login_user @admin_user
    # создаем новый без зависимостей от ставок
    @new_stake_type = StakeType.create(
      :title => "asd",
      :numeric => "true"
    )
    assert_difference 'StakeType.count', -1 do
      delete :destroy, id: @new_stake_type
    end
    assert_redirected_to stake_types_path
  end
end
