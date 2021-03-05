class Ecg < ApplicationRecord
  belongs_to :patient
  has_one :ecg_datum
  has_one :ecg_raw
end
