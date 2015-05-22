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
#  winner        :boolean          default(FALSE)
#  paid          :boolean          default(FALSE)
#  created_at    :timestamp withou not null
#  updated_at    :timestamp withou not null
#
# Indexes
#
#  index_stakes_on_bet_id         (bet_id)
#  index_stakes_on_stake_type_id  (stake_type_id)
#  index_stakes_on_user_id        (user_id)
#

class Stake < ActiveRecord::Base
  validates :bid, :presence => true
  validates :stake_type, :presence => true
  validates :user, :presence => true
  validates :bet, :presence => true

  belongs_to :user
  belongs_to :bet
  belongs_to :stake_type
end
