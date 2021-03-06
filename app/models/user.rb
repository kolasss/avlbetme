# == Schema Information
#
# Table name: users
#
#  id                           :integer          not null, primary key
#  name                         :string           not null
#  photo                        :string
#  created_at                   :datetime
#  updated_at                   :datetime
#  remember_me_token            :string
#  remember_me_token_expires_at :datetime
#  friends                      :jsonb            default({}), not null
#  role                         :integer          default(0), not null
#
# Indexes
#
#  index_users_on_friends            (friends)
#  index_users_on_remember_me_token  (remember_me_token)
#

class User < ActiveRecord::Base
  authenticates_with_sorcery!

  # authenticates_with_sorcery! do |config|
  #   config.authentications_class = Authentication
  # end

  enum role: {
    guest: 0,
    admin: 1
  }

  validates :name, :presence => true

  has_many :authentications, :dependent => :destroy
  accepts_nested_attributes_for :authentications

  has_many :stakes, :dependent => :restrict_with_error
  has_many :bets, through: :stakes

  has_many :activities, :dependent => :restrict_with_error,
      class_name: Feed::Activity
  has_many :notifications, :dependent => :destroy
  has_many :friends_activities, through: :notifications,
      source: :activity

  # store_accessor :friends, :vk_friends_ids

  def get_friends_from_vk
    require 'open-uri'
    friends['vk_friends_ids'] = JSON.parse(open("https://api.vk.com/method/friends.get?user_id=#{vk_id}").read)['response']
    save
  end

  def vk_id
    authentications.where(provider: :vk).first.uid
  end

  def friends_list
    vk_friends_ids = friends['vk_friends_ids']
    User.joins(:authentications).merge(Authentication.where provider: :vk, uid: vk_friends_ids)
  end

  def friends_list_with_self
    friends_list << self
  end
end
