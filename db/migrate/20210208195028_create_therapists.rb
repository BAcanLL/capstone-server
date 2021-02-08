class CreateTherapists < ActiveRecord::Migration[5.1]
  def change
    create_table :therapists do |t|
      t.string :email
      t.string :password_digest
      t.string :first_name
      t.string :last_name
      t.string :prefix
      t.string :profession

      t.timestamps
    end
  end
end
