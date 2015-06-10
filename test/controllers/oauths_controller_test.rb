require 'test_helper'

class OauthsControllerTest < ActionController::TestCase
  test "should get oauth" do
    get :oauth, provider: 'vk'
    assert_response :redirect
  end

  # TODO: чето сделать для теста логинов???
  # test "should get callback" do
  #   get :callback, provider: 'vk'
  #   assert_response :success
  # end
end
