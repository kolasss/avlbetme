# == Schema Information
#
# Table name: stake_types
#
#  id         :integer          not null, primary key
#  title      :string           not null
#  numeric    :boolean          default(FALSE)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class StakeType < ActiveRecord::Base
  validates :title, :presence => true

  has_many :stakes, :dependent => :restrict_with_error

  scope :numeric, -> { where(numeric: true) }
end
