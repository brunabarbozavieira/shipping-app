class AddContactPhoneToServiceOrder < ActiveRecord::Migration[7.0]
  def change
    add_column :service_orders, :contact_phone, :string
  end
end
