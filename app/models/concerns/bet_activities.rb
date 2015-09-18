module BetActivities
  extend ActiveSupport::Concern

  included do
    has_many :activities, :dependent => :nullify,
      class_name: Feed::Activity
  end

  def log_creation user
    Feed::BetCreate.create_activity user, self
  end

  def log_update user
    Feed::BetUpdate.create_activity user, self
  end

  def log_deletion user
    Feed::BetDestroy.create_activity user, self
  end

  # protected
end
