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
  class Activity < ActiveRecord::Base
    belongs_to :user
    belongs_to :bet

    validates :user, presence: true

    default_scope { order(created_at: :desc) }

    store_accessor :details, :bet_title

    def to_partial_path
      # "feed/#{self.class.name.demodulize.underscore}"
      "feed/bet_create"
    end

  end
end
