require 'test_helper'

class SiteLayoutTest < ActionDispatch::IntegrationTest

  test "layout links for guest" do
    get root_path
    assert_template 'home/index'
    assert_select "a[href=?]", root_path
    assert_select "a[href=?]", auth_at_provider_path(:provider => :vk)
    assert_select "a[href=?]", new_bet_path, false
    assert_select "a[href=?]", log_out_path, false
    assert_select "a[href=?]", users_path, false
    assert_select "a[href=?]", stake_types_path, false
  end

  test "layout links for user" do
    user_session = login_session(:depp)

    user_session.get root_path
    user_session.assert_template 'home/index'
    user_session.assert_select "a[href=?]", root_path
    user_session.assert_select "a[href=?]", new_bet_path
    user_session.assert_select "a[href=?]", user_path(user_session.controller.current_user)
    user_session.assert_select "a[href=?]", log_out_path
    user_session.assert_select "a[href=?]", users_path, false
    user_session.assert_select "a[href=?]", stake_types_path, false
  end

  test "layout links for admin" do
    user_session = login_session(:jolie)

    user_session.get root_path
    user_session.assert_template 'home/index'
    user_session.assert_select "a[href=?]", root_path
    user_session.assert_select "a[href=?]", new_bet_path
    user_session.assert_select "a[href=?]", user_path(user_session.controller.current_user)
    user_session.assert_select "a[href=?]", log_out_path
    user_session.assert_select "a[href=?]", users_path
    user_session.assert_select "a[href=?]", stake_types_path
  end
end
