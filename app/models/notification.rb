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

class Notification < ActiveRecord::Base
  belongs_to :user
  belongs_to :activity, class_name: Feed::Activity

  validates :user, :presence => true
  validates :activity, :presence => true
end
