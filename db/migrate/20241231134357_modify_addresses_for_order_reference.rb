class ModifyAddressesForOrderReference < ActiveRecord::Migration[7.0]
  def change
    # user_id が存在する場合のみ削除
    remove_column :addresses, :user_id, :bigint if column_exists?(:addresses, :user_id)
    
    # item_id が存在する場合のみ削除
    remove_column :addresses, :item_id, :bigint if column_exists?(:addresses, :item_id)

    # token が存在する場合のみ削除
    remove_column :addresses, :token, :string if column_exists?(:addresses, :token)

    # order_id を追加
    add_reference :addresses, :order, null: false, foreign_key: true unless column_exists?(:addresses, :order_id)
  end
end