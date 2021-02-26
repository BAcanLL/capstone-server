class Medication < ApplicationRecord
  belongs_to :patient
  validates :name, presence: true
  validates :time, presence: true
end
