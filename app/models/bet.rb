class Bet < ActiveRecord::Base
  validates :title, :presence => true

  enum status: {
    opened: 0,
    finished: 1,
    canceled: 2
  }
end
