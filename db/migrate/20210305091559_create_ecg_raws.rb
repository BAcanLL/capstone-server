class CreateEcgRaws < ActiveRecord::Migration[5.1]
  def change
    create_table :ecg_raws do |t|
      t.references :ecg, foreign_key: true
      t.string :classification
      t.string :symptoms
      t.string :device
      t.string :sample_rate
      t.string :unit
      t.string :values

      t.timestamps
    end
  end
end
