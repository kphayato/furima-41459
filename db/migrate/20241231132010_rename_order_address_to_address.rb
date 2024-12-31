class RenameOrderAddressToAddress < ActiveRecord::Migration[6.0]
  def change
    rename_table :order_addresses, :addresses
  end
end