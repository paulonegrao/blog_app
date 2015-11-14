class User < ActiveRecord::Base
  has_secure_password

  validates :email, presence: true, uniqueness: true

  has_many :posts, dependent: :nullify

  has_many :comments, dependent: :nullify
end
