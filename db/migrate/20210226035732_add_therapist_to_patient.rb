class AddTherapistToPatient < ActiveRecord::Migration[5.1]
  def change
    add_reference :patients, :therapist
  end
end
