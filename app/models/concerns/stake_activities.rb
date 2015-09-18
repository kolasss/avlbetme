module StakeActivities
  extend ActiveSupport::Concern

  included do
    has_many :activities, :dependent => :nullify,
      class_name: Feed::Activity
  end

  # def log_creation user
  #   activities.create(
  #     type: 'Feed::StakeCreate',
  #     user: user,
  #     bet: bet
  #   )
  # end

  # def log_update user
  #   if previous_changes.present?
  #     details = previous_changes.except('updated_at')
  #     activities.create(
  #       type: 'Feed::StakeUpdate',
  #       user: user,
  #       details: details
  #     )
  #   end
  # end

  # def log_destroy user
  #   Feed::StakeDestroy.create(
  #     user: user,
  #     details: {bet_title: title}
  #   )
  # end

  def log_creation user
    Feed::StakeCreate.create_activity user, self
  end

  def log_update user
    Feed::StakeUpdate.create_activity user, self
  end

  def log_deletion user
    Feed::StakeDestroy.create_activity user, self
  end
end
