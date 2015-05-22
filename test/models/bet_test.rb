require 'test_helper'

class BetTest < ActiveSupport::TestCase

  def setup
    @bet = Bet.new(
      title: "Проверочное пари"
    )
  end

  test "should be valid" do
    assert @bet.valid?
  end

  test "title should be present" do
    @bet.title = "     "
    assert_not @bet.valid?
  end

  test "status should be opened" do
    assert @bet.opened?
  end
end
