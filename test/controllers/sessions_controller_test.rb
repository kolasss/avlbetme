require 'test_helper'

class SessionsControllerTest < ActionController::TestCase
  test "should get destroy" do
    get :destroy
    assert_redirected_to root_path
  end
end
