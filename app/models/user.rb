class User < ApplicationRecord
  has_many :friends
  has_many :friend_users, through: :friends

  def friend_ids
    Friend.where(user_id: id).pluck(:friended_user_id)
  end

  def self_and_friend_ids
    self.friend_ids << id
  end

  def prospect_ids
    Friend.where.not(user_id: self_and_friend_ids).where(friended_user_id: friend_ids).pluck(:user_id)
  end
end
