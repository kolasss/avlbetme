require 'test_helper'

class SiteLayoutTest < ActionDispatch::IntegrationTest
  # include Sorcery::TestHelpers::Rails::Controller
  # include Sorcery::TestHelpers::Rails::Integration
  test "layout links for guest" do
    get root_path
    assert_template 'home/index'
    assert_select "a[href=?]", root_path
    assert_select "a[href=?]", auth_at_provider_path(:provider => :vk)
  end

  test "layout links for user" do
    user_session = login(:depp)

    user_session.get root_path
    user_session.assert_template 'home/index'
    user_session.assert_select "a[href=?]", root_path
    user_session.assert_select "a[href=?]", new_bet_path
    user_session.assert_select "a[href=?]", user_path(user_session.controller.current_user)
    user_session.assert_select "a[href=?]", log_out_path

  end

  # test "Sign up page" do
  #   get signup_path
  #   assert_template 'users/new'
  #   assert_select "title", full_title("Sign up")
  # end

end
