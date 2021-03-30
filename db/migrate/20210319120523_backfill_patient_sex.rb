class BackfillPatientSex < ActiveRecord::Migration[5.1]
  def change
    Patient.find_each do |patient|
      patient.update!(sex: "female")
    end
  end
end
