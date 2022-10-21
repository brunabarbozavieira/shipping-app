class AddStartDateToServiceOrder < ActiveRecord::Migration[7.0]
  def change
    add_column :service_orders, :start_date, :datetime
  end
end
