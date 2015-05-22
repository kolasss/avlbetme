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
end
