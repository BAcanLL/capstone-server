class CreateSessions < ActiveRecord::Migration[5.1]
  def change
    create_table :sessions do |t|
      t.string :token
      t.references :therapist
      t.references :patient
    end
  end
end
