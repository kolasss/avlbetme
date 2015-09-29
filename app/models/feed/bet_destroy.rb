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
  class BetDestroy < Activity

    def BetDestroy.create_activity user, bet
      activity = create(
        user: user,
        details: {bet_title: bet.title}
      )
      activity.notify bet.users
    end

    protected

      def users_for_notify users
        users
      end

  end
end
