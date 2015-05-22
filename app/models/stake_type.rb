# == Schema Information
#
# Table name: stake_types
#
#  id         :integer          not null, primary key
#  title      :character varyin not null
#  numeric    :boolean          default(FALSE)
#  created_at :timestamp withou not null
#  updated_at :timestamp withou not null
#

class StakeType < ActiveRecord::Base
  validates :title, :presence => true

  has_many :stakes, :dependent => :restrict_with_error
end
