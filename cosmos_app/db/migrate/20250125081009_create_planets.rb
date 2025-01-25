class CreatePlanets < ActiveRecord::Migration[8.0]
  def change
    create_table :planets do |t|
      t.string :name
      t.references :star, null: false, foreign_key: true
      t.string :planet_type
      t.float :mass
      t.float :temperature

      t.timestamps
    end
  end
end
