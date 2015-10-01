require 'test_helper'

class ActivitiesHelperTest < ActionView::TestCase

  test "activity_user_link helper" do
    user = users(:depp)
    html = activity_user_link user
    assert_match user_path(user), html
    assert_match user.name, html
  end

  test "activity_stake_user_link helper" do
    activity = feed_activities(:two)
    user = activity.stake.user
    html = activity_stake_user_link activity
    assert_match user_path(user), html
    assert_match user.name, html

    # without stake
    activity = feed_activities(:without_stake)
    user_name = activity.stake_user_name
    html = activity_stake_user_link activity
    assert_match user_name, html
  end

  test "activity_bet_link helper" do
    activity = feed_activities(:one)
    html = activity_bet_link activity
    bet_link = bet_path(activity.bet)
    bet_title = activity.bet.title
    assert_match bet_link, html
    assert_match bet_title, html

    # without bet
    activity = feed_activities(:without_bet)
    bet_title = activity.bet_title
    html = activity_bet_link activity
    assert_match bet_title, html
  end

  test "activity_updates helper" do
    activity = feed_activities(:update_bet)
    html = activity_updates activity
    old_data = activity.updates.first.last[0]
    new_data = activity.updates.first.last[1]
    assert_match old_data, html
    assert_match new_data, html
  end

  test 'activity_update_content private helper with simpe data' do
    update = {"body"=>["old", "new"]}.first
    html = activity_update_content update
    old_data = update.last[0]
    new_data = update.last[1]
    assert_match old_data, html
    assert_match new_data, html
  end

  test 'activity_update_content private helper with user_id' do
    new_user    = users(:pit)
    new_user_id = new_user.id
    update = {"user_id"=>[1, new_user_id]}.first
    html = activity_update_content update
    old_data = "Пользователь не найден"
    new_data = new_user.name
    assert_match old_data, html
    assert_match new_data, html
  end

  test 'activity_update_content private helper with stake_type_id' do
    new_type    = stake_types(:rub)
    new_type_id = new_type.id
    update = {"stake_type_id"=>[1, new_type_id]}.first
    html = activity_update_content update
    old_data = "Тип ставки не найден"
    new_data = new_type.title
    assert_match old_data, html
    assert_match new_data, html
  end

end
