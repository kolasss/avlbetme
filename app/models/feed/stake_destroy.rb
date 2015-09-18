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
  class StakeDestroy < Activity
    store_accessor :details, :stake_user_name

    def StakeDestroy.create_activity user, stake
      details = {
        bet_title: stake.bet.title,
        stake_user_name: stake.user.name
      }
      create(
        user: user,
        bet: stake.bet,
        details: details
      )
    end
  end
end
