class Therapist < ApplicationRecord
  has_many :patients
  has_secure_password
  before_save { email.downcase! }
  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :prefix, presence: true
  validates :profession, presence: true
  validates :code, presence: true

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true,
                    uniqueness: { case_sensitive: false },
                    length: { maximum: 255 },
                    format: { with: VALID_EMAIL_REGEX }

end
