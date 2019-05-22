class Friend < ApplicationRecord
  belongs_to :user
  belongs_to :friended_user, class_name: "User"

  after_create :create_inverse, unless: :has_inverse?

  def create_inverse
    self.class.create(inverse_match_options)
  end

  def has_inverse?
    self.class.exists?(inverse_match_options)
  end

  def inverse_match_options
    { friended_user_id: user_id, user_id: friended_user_id }
  end
end
