class AddShippingDayIdToItems < ActiveRecord::Migration[7.0]
  def change
    add_column :items, :shipping_day_id, :integer, null: false, default: 1
  end
end