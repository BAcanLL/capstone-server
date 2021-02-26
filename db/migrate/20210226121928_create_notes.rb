class CreateNotes < ActiveRecord::Migration[5.1]
  def change
    create_table :notes do |t|
      t.datetime :time
      t.string :text
      t.references :patient, foreign_key: true

      t.timestamps
    end
  end
end
