class CreatePriceByDistances < ActiveRecord::Migration[7.0]
  def change
    create_table :price_by_distances do |t|
      t.integer :minimum_distance
      t.integer :maximum_distance
      t.decimal :rate

      t.timestamps
    end
  end
end
