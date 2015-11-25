class Post < ActiveRecord::Base
  belongs_to :category

  validates :title, presence: true, uniqueness: true

  belongs_to :user

  has_many :comments, dependent: :destroy

  has_many :likes, dependent: :nullify
  has_many :liking_users, through: :likes, source: :user

  has_many :taggings, dependent: :destroy
  has_many :tags, through: :taggings

  def like_for(user)
    likes.find_by_user_id(user.id)
  end

  def liked_by?(user)
    like_for(user).present?
  end

end
