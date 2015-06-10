# == Schema Information
#
# Table name: bets
#
#  id         :integer          not null, primary key
#  title      :character varyin not null
#  body       :text
#  started_at :timestamp withou
#  stopped_at :timestamp withou
#  status     :integer          default(0), not null
#  created_at :timestamp withou not null
#  updated_at :timestamp withou not null
#

class Bet < ActiveRecord::Base
  validates :title, :presence => true

  enum status: {
    opened: 0,
    finished: 1,
    canceled: 2
  }

  has_many :stakes, :dependent => :destroy
  has_many :users, through: :stakes

  scope :by_created, -> { order(created_at: :desc) }
  # scope :old, -> { where(status: [
  #   Bet.statuses[:finished],
  #   Bet.statuses[:canceled]
  # ]) }

  # для создания дефолтной ставки
  def create_default_stake_for_user user_id
    default_params = {
      bid: 0,
      user_id: user_id,
      stake_type: StakeType.first
    }
    stakes.create! default_params
  end

  def finish! results = {}
    unless results.has_value? 'win'
      errors.add(:finish, I18n.t('bet.messages.add_winner'))
      return false
    end
    finish_stakes results
    finished!
  end

  def cancel!
    canceled!
    stakes.each do |stake|
      stake.pass!
    end
  end

  def has_user? user
    users.include? user
  end

  private

    def finish_stakes results
      stakes.each do |stake|
        new_status = results[stake.id.to_s]
        if new_status.present?
          stake.status = new_status
          stake.save
        end
      end
    end
end
