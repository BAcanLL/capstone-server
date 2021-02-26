class CreateEmotes < ActiveRecord::Migration[5.1]
  def change
    create_table :emotes do |t|
      t.datetime :time
      t.string :value
      t.references :patient

      t.timestamps
    end
  end
end
