class User < ApplicationRecord
  before_create :confirmation_token
  has_many :user_videos, dependent: :destroy
  has_many :videos, through: :user_videos

  validates :email, uniqueness: true, presence: true
  validates :password, presence: true
  validates :first_name, presence: true
  enum role: { default: 0, admin: 1 }
  has_secure_password

  def email_activate
    self.status = 'active'
    self.confirm_token = nil
    save!(:validate => false)
  end

  private

  def confirmation_token
    if self.confirm_token.nil?
        self.confirm_token = SecureRandom.urlsafe_base64.to_s
    end
  end
end
