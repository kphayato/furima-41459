class RemoveStatusFromOrders < ActiveRecord::Migration[6.1]
  def change
    remove_column :orders, :status, :string # カラムの型を適切に変更（例: :string, :integer）
  end
end