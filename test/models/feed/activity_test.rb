# == Schema Information
#
# Table name: feed_activities
#
#  id         :integer          not null, primary key
#  user_id    :integer
#  bet_id     :integer
#  stake_id   :integer
#  type       :string
#  details    :jsonb            default({}), not null
#  created_at :datetime         not null
#
# Indexes
#
#  index_feed_activities_on_bet_id    (bet_id)
#  index_feed_activities_on_stake_id  (stake_id)
#  index_feed_activities_on_user_id   (user_id)
#

require 'test_helper'

class Feed::ActivityTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
  # TODO tests for activities
end
