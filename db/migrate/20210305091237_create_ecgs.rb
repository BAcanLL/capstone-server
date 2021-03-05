class CreateEcgs < ActiveRecord::Migration[5.1]
  def change
    create_table :ecgs do |t|
      t.references :patient, foreign_key: true
      t.datetime :recorded_data

      t.timestamps
    end
  end
end
