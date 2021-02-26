class Patient < ApplicationRecord
  belongs_to :therapist, optional: true
  has_secure_password
  before_save { email.downcase! }
  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :height, presence: true
  validates :weight, presence: true
  validates :birthday, presence: true

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true,
                    uniqueness: { case_sensitive: false },
                    length: { maximum: 255 },
                    format: { with: VALID_EMAIL_REGEX }

end
