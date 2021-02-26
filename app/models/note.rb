class Note < ApplicationRecord
  belongs_to :patient
  validates :text, presence: true
  validates :time, presence: true
end
