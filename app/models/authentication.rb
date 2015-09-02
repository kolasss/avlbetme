# == Schema Information
#
# Table name: authentications
#
#  id         :integer          not null, primary key
#  user_id    :integer          not null
#  provider   :string           not null
#  uid        :string           not null
#  created_at :datetime
#  updated_at :datetime
#
# Indexes
#
#  index_authentications_on_provider_and_uid  (provider,uid)
#

class Authentication < ActiveRecord::Base
  belongs_to :user
end
