require 'test_helper'

class ApplicationHelperTest < ActionView::TestCase
  def setup
    @view_flow = ActionView::OutputFlow.new
  end

  test "full title helper" do
    assert_equal full_title, "AvlBet.Me"
    title("Help")
    assert_equal full_title, "Help | AvlBet.Me"
  end
end
