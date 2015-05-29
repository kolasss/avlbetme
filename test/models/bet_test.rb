# == Schema Information
#
# Table name: bets
#
#  id         :integer          not null, primary key
#  title      :character varyin not null
#  body       :text
#  started_at :timestamp withou
#  stopped_at :timestamp withou
#  status     :integer          default(0), not null
#  created_at :timestamp withou not null
#  updated_at :timestamp withou not null
#

require 'test_helper'

class BetTest < ActiveSupport::TestCase

  def setup
    @bet = Bet.new(
      title: "Проверочное пари",
      body: "olololo"
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

  test "should have users" do
    depp = users(:depp)
    bet = bets(:finished)

    assert bet.users.include? depp
  end
end
