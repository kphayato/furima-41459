class Order < ApplicationRecord
  attr_accessor :token
  
  belongs_to :user
  belongs_to :item

  # バリデーション
  validates :item, presence: true
  validates :user, presence: true
  validates :token, presence: true

  # Itemのpriceを取得するメソッド
  def price
    item.price
  end
end