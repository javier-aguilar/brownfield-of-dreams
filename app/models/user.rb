class User < ApplicationRecord
  has_many :user_videos, dependent: :destroy
  has_many :videos, through: :user_videos

  has_many :friendships, dependent: :destroy
  has_many :friends, through: :friendships

  validates :email, uniqueness: true, presence: true
  validates :password, presence: true, on: create
  validates :first_name, presence: true
  enum role: { default: 0, admin: 1 }
  has_secure_password

  def bookmarks
    videos.joins(:tutorial)
          .select('videos.*, tutorials.title tutorial_title')
          .order(:tutorial_id, :position)
          .group_by(&:tutorial_title)
  end
end
