class CreatePatients < ActiveRecord::Migration[5.1]
  def change
    create_table :patients do |t|
      t.string :email
      t.string :password_digest
      t.string :first_name
      t.string :last_name
      t.integer :height
      t.integer :weight
      t.date :birthday

      t.timestamps
    end
  end
end
