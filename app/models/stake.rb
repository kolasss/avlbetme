# == Schema Information
#
# Table name: stakes
#
#  id            :integer          not null, primary key
#  objective     :text
#  bid           :text             default("0"), not null
#  stake_type_id :integer
#  user_id       :integer
#  bet_id        :integer
#  status        :integer          default(0), not null
#  paid          :boolean          default(FALSE)
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#
# Indexes
#
#  index_stakes_on_bet_id         (bet_id)
#  index_stakes_on_stake_type_id  (stake_type_id)
#  index_stakes_on_user_id        (user_id)
#

class Stake < ActiveRecord::Base
  audited :associated_with => :bet

  validates :bid, :presence => true
  validates :stake_type, :presence => true
  validates :user, :presence => true,
                   uniqueness: {scope: :bet_id}
  validates :bet, :presence => true

  belongs_to :user
  belongs_to :bet
  belongs_to :stake_type

  enum status: {
    pass: 0,
    win: 1,
    lose: 2
  }

  # label method для вывода имени в формах
  def user_name
    user.name
  end

  def not_last?
    bet.stakes.length > 1
  end
end
