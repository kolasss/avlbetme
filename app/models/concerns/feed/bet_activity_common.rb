module Feed
  module BetActivityCommon
    extend ActiveSupport::Concern

    included do
      before_create :store_metadata
    end

    protected
      def store_metadata
        self.details ||= {}
        self.details.merge!({bet_title: bet.title})
      end
  end
end
