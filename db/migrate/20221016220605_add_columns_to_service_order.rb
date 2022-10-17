class AddColumnsToServiceOrder < ActiveRecord::Migration[7.0]
  def change
    add_column :service_orders, :total_delivery_value, :decimal
    add_column :service_orders, :deadline, :integer
    add_reference :service_orders, :shipping_method, null: true, foreign_key: true
  end
end
