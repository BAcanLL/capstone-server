class CreateEcgData < ActiveRecord::Migration[5.1]
  def change
    create_table :ecg_data do |t|
      t.integer :hr
      t.integer :hrv
      t.integer :pnn50
      t.integer :nn50
      t.integer :lfhf
      t.boolean :anomaly
      t.references :ecg, foreign_key: true

      t.timestamps
    end
  end
end
