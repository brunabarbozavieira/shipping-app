class CreatePriceByWeights < ActiveRecord::Migration[7.0]
  def change
    create_table :price_by_weights do |t|
      t.integer :minimum_weight
      t.integer :maximum_weight
      t.decimal :price_per_kilometer

      t.timestamps
    end
  end
end
