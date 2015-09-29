# == Schema Information
#
# Table name: notifications
#
#  id          :integer          not null, primary key
#  user_id     :integer
#  activity_id :integer
#  created_at  :datetime         not null
#
# Indexes
#
#  index_notifications_on_activity_id  (activity_id)
#  index_notifications_on_user_id      (user_id)
#

require 'test_helper'

class NotificationTest < ActiveSupport::TestCase
  def setup
    @notification = Notification.new(
      user_id: users(:depp).id,
      activity_id: feed_activities(:one).id
    )
  end

  test "should be valid" do
    assert @notification.valid?
  end

  test "title should be present" do
    @notification.user = nil
    assert_not @notification.valid?
  end

  test "stake_type should be present" do
    @notification.activity = nil
    assert_not @notification.valid?
  end
end
