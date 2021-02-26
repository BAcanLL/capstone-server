class CreateMedications < ActiveRecord::Migration[5.1]
  def change
    create_table :medications do |t|
      t.datetime :time
      t.string :name
      t.references :patient, foreign_key: true

      t.timestamps
    end
  end
end
