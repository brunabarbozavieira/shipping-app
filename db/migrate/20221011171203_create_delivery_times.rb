class CreateDeliveryTimes < ActiveRecord::Migration[7.0]
  def change
    create_table :delivery_times do |t|
      t.integer :minimum_distance
      t.integer :maximum_distance
      t.integer :deadline_in_hours

      t.timestamps
    end
  end
end
