class Patient < ApplicationRecord
  belongs_to :therapist, optional: true
  has_many :ecgs
  has_many :emotes
  has_many :words
  has_many :medications
  has_many :notes
  has_one :session
  has_secure_password
  before_save { email.downcase! }
  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :height, presence: true
  validates :weight, presence: true
  validates :birthday, presence: true
  validates :sex, presence: true

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true,
                    uniqueness: { case_sensitive: false },
                    length: { maximum: 255 },
                    format: { with: VALID_EMAIL_REGEX }

end
