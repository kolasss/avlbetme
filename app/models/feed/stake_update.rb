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

module Feed
  class StakeUpdate < Activity
    include StakeActivityCommon

    store_accessor :details, :updates

    def StakeUpdate.create_activity user, stake
      if stake.previous_changes.present?
        updates = stake.previous_changes.except('updated_at')
        details = {updates: updates}
        activity = create(
          user: user,
          bet: stake.bet,
          stake: stake,
          details: details
        )
        activity.notify user
      end
    end

  end
end
