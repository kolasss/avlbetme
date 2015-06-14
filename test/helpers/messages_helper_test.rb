require 'test_helper'

class MessagesHelperTest < ActionView::TestCase
  include IconsHelper
  include FontAwesome::Rails::IconHelper

  test "messages helper" do
    flash[:notice] = "Yeah!"
    flash[:alert] = "Fuck!"

    html = messages.to_s
    assert_match 'alert-success', html
    assert_match 'alert-danger', html
    assert_match 'Yeah!', html
    assert_match 'Fuck!', html
  end
end

