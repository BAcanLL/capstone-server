class AddScoreToWords < ActiveRecord::Migration[5.1]
  def change
    add_column :words, :score, :string
  end
end
