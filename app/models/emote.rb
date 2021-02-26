class Emote < ApplicationRecord
  belongs_to :patient
  validates :value, presence: true
  validates :time, presence: true
end
