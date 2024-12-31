class ModifyAddressesForOrderReference < ActiveRecord::Migration[7.0]
  def change
    # user_id と item_id を削除
    remove_column :addresses, :user_id, :bigint
    remove_column :addresses, :item_id, :bigint
    remove_column :addresses, :token, :string

    # order_id を追加
    add_reference :addresses, :order, null: false, foreign_key: true
  end
end