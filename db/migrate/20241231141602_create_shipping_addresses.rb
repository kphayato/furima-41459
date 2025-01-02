class CreateShippingAddresses < ActiveRecord::Migration[6.0]
  def change
    create_table :shipping_addresses do |t|
      t.references :order, null: false, foreign_key: true  # 注文IDを外部キーとして設定
      t.string :postal_code
      t.integer :prefecture
      t.string :city
      t.string :street_address
      t.string :building_name
      t.string :phone_number

      t.timestamps
    end
  end
end