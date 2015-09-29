module Feed
  module StakeActivityCommon
    extend ActiveSupport::Concern

    included do
      belongs_to :stake

      before_create :store_metadata

      store_accessor :details, :stake_user_name
    end

    protected

      def store_metadata
        self.details ||= {}
        self.details.merge!({
          bet_title: bet.title,
          stake_user_name: stake.user.name
        })
      end

      def users_for_notify user
        (stake.present? && stake.user != user) ? [stake.user] : []
      end

  end
end
