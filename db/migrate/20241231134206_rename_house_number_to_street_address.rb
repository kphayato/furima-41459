class RenameHouseNumberToStreetAddress < ActiveRecord::Migration[6.0]
  def change
    rename_column :addresses, :house_number, :street_address
  end
end