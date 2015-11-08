class Post < ActiveRecord::Base
  has_many :comments, dependent: :destroy
  validates :title, presence: true, uniqueness: true
end
