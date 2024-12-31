class DropShippingAddresses < ActiveRecord::Migration[7.0]
  def change
    drop_table :shipping_addresses
  end
end