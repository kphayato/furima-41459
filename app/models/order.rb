class Order < ApplicationRecord
  belongs_to :user
  belongs_to :item
  belongs_to :shipping_address
  has_one :shipping_address, dependent: :destroy
  accepts_nested_attributes_for :shipping_address

  # バリデーション
  validates :item, presence: true
  validates :user, presence: true
  validates :status, presence: true

  # Itemのpriceを取得するメソッド
  def price
    item.price
  end
end