require 'test_helper'

class UsersControllerTest < ActionController::TestCase

  def setup
    @user       = users(:depp)
    @admin_user = users(:jolie)
  end

  test "should redirect index when not logged in" do
    get :index
    assert_redirected_to root_url
  end

  test "should get show" do
    get :show, id: @user
    assert_response :success
  end

  test "should redirect destroy when not logged in" do
    delete :destroy, id: @user
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

  test "should redirect destroy when logged in as a non-admin" do
    login_user @user
    assert_no_difference 'User.count' do
      delete :destroy, id: @user
    end
    assert_redirected_to root_url
  end

  test "should destroy when logged in as admin" do
    login_user @admin_user
    # создаем нового без зависимостей от ставок
    @new_user = User.create( name: 'asd' )
    assert_difference 'User.count', -1 do
      delete :destroy, id: @new_user
    end
    assert_redirected_to users_path
  end
end
