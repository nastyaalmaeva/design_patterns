class CreateStars < ActiveRecord::Migration[8.0]
  def change
    create_table :stars do |t|
      t.string :name
      t.string :spectral_class
      t.float :temperature
      t.float :mass
      t.string :color

      t.timestamps
    end
  end
end
