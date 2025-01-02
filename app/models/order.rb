class Order < ApplicationRecord
  belongs_to :item
  belongs_to :user
  has_one :shipping_address, dependent: :destroy
  accepts_nested_attributes_for :shipping_address

  # Itemのpriceを取得するメソッド
  def price
    item.price  # Itemに紐づくpriceを返す
  end
end