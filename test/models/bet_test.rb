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

  test "associated stakes should be destroyed" do
    @bet.save
    @stake = @bet.stakes.new(
      bid: "1000",
      stake_type_id: stake_types(:rub).id,
      user_id: users(:jolie).id,
      objective: 'Подтянуться 10 раз'
    )
    @stake.save
    assert_difference 'Stake.count', -1 do
      @bet.destroy
    end
  end

  test "method create_default_stake_for_user should create stake" do
    @bet.save
    depp = users(:depp)

    assert_difference 'Stake.count', 1 do
      @bet.create_default_stake_for_user depp.id
    end

    assert depp.bets.include? @bet
  end

  test "method finish! should correctly finish bet" do
    opened_bet = bets(:opened)
    winners_stake = opened_bet.stakes.first
    losers_stake = opened_bet.stakes.second
    pass_stake = opened_bet.stakes.third

    results = {
      winners_stake.id.to_s => 'win',
      losers_stake.id.to_s => 'lose',
      pass_stake.id.to_s => 'pass'
    }

    opened_bet.finish! results

    winners_stake.reload
    losers_stake.reload
    pass_stake.reload
    assert opened_bet.finished?
    assert winners_stake.win?
    assert losers_stake.lose?
    assert pass_stake.pass?
  end

  test "method finish! should require winners id" do
    opened_bet = bets(:opened)

    assert_not opened_bet.finish! {"asd"}
    assert opened_bet.opened?
    assert opened_bet.errors[:finish].any?
    opened_bet.stakes.each do |stake|
      assert stake.pass?
    end
  end

  test "method cancel! should correctly cancel bet" do
    opened_bet = bets(:opened)
    opened_bet.cancel!

    assert opened_bet.canceled?
    opened_bet.stakes.each do |stake|
      assert stake.pass?
    end

    finished_bet = bets(:finished)
    finished_bet.cancel!

    assert finished_bet.canceled?
    finished_bet.stakes.each do |stake|
      assert stake.pass?
    end
  end

  test "method has_user? should correctly determine whether the user in bet" do
    depp = users(:depp)
    jolie = users(:jolie)
    bet = bets(:finished)

    assert bet.has_user? depp
    assert_not bet.has_user? jolie
  end
end
