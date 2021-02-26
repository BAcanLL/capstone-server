class AddCodeToTherapist < ActiveRecord::Migration[5.1]
  def change
    add_column :therapists, :code, :string
  end
end
