class Order < ApplicationRecord
  attr_accessor :token
  
  belongs_to :user
  belongs_to :item
  has_one :shipping_address

  # バリデーション
  validates :item, presence: true
  validates :user, presence: true

  # Itemのpriceを取得するメソッド
  def price
    item.price
  end
end