class Post < ActiveRecord::Base

  validates :title, presence: true, uniqueness: true

  belongs_to :user

  has_many :comments, dependent: :destroy

  has_many :likes, dependent: :nullify
  has_many :liking_users, through: :likes, source: :user

  def like_for(user)
    likes.find_by_user_id(user.id)
  end

  def liked_by?(user)
    like_for(user).present?
  end
  
end
