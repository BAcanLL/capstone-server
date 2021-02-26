class Session < ApplicationRecord
  has_one :therapist
  has_one :patient
  validates :token, presence: true

end
