class AddAttributesToServiceOrder < ActiveRecord::Migration[7.0]
  def change
    add_column :service_orders, :delivery_date, :datetime
    add_column :service_orders, :reason_for_delay, :string
  end
end
