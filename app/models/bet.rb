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

  # scope :loss, -> (id) { where customer_id: id }

  # для создания дефолтной ставки
  def create_default_stake_for_user user_id
    default_params = {
      bid: 0,
      user_id: user_id,
      stake_type: StakeType.first
    }
    stakes.create! default_params
  end

  def finish! win_ids, pass_ids=[]
    if win_ids.empty?
      errors.add(:finish, "Выберите победителя")
      return
    end

    finished!

    stakes.where(id: win_ids).each do |stake|
      stake.win!
    end
    stakes.where(id: pass_ids).each do |stake|
      stake.pass!
    end
    lose_ids = win_ids + pass_ids
    stakes.where.not(id: lose_ids).each do |stake|
      stake.lose!
    end
  end

  def cancel!
    canceled!
    stakes.each do |stake|
      stake.pass!
    end
  end
end
