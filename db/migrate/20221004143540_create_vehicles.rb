class CreateVehicles < ActiveRecord::Migration[7.0]
  def change
    create_table :vehicles do |t|
      t.string :license_plate
      t.string :brand
      t.string :model
      t.string :year_of_manufacture
      t.integer :maximum_load_capacity

      t.timestamps
    end
  end
end
