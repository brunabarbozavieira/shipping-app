class CreateServiceOrders < ActiveRecord::Migration[7.0]
  def change
    create_table :service_orders do |t|
      t.string :initial_full_address
      t.string :product_code
      t.string :dimensions
      t.decimal :weight
      t.string :recipient_name
      t.string :identification_document
      t.string :email
      t.string :service_order_code
      t.integer :total_distance
      t.integer :status, default: 0

      t.timestamps
    end
  end
end
