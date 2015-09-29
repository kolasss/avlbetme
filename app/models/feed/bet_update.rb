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
  class BetUpdate < Activity
    include BetActivityCommon

    store_accessor :details, :updates

    def BetUpdate.create_activity user, bet
      if bet.previous_changes.present?
        updates = bet.previous_changes.except('updated_at')
        details = {updates: updates}
        activity = create(
          user: user,
          bet: bet,
          details: details
        )
        activity.notify user
      end
    end

    protected

      def users_for_notify user
        bet.present? ? bet.users.where.not(id: user.id) : []
      end

  end
end
