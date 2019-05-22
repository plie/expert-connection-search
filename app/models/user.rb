class User < ApplicationRecord
  has_many :friends
  has_many :friend_users, through: :friends

  def friends
    Friend.where(user_id: id).pluck(:friended_user_id)
  end

  def self_and_friends
    self.friends << id
  end

  def prospects
    Friend.where.not(user_id: self_and_friends).where(friended_user_id: friends).pluck(:user_id)
  end

end
