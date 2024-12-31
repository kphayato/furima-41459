class CreateShippingAddresses < ActiveRecord::Migration[7.0]
  def change
    create_table :shipping_addresses do |t|
      t.references :order, null: false, foreign_key: true
      t.string :postal_code
      t.string :prefecture
      t.string :city
      t.string :house_number
      t.string :building_name

      t.timestamps
    end
  end
end
