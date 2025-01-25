class CreateSattelites < ActiveRecord::Migration[8.0]
  def change
    create_table :sattelites do |t|
      t.string :name
      t.references :planet, null: false, foreign_key: true
      t.string :sattelite_type
      t.float :mass
      t.float :temperature
      t.string :form

      t.timestamps
    end
  end
end
