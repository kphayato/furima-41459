class Order < ApplicationRecord
  belongs_to :user
  belongs_to :product
  has_one :shipping_address, dependent: :destroy

  # 配送先情報をネスト可能にする
  accepts_nested_attributes_for :shipping_address

  # 注文金額を商品価格から設定
  before_create :set_price_from_product

  # ステータスの検証
  validates :status, presence: true, inclusion: { in: ['pending', 'completed', 'shipped', 'canceled'], message: "%{value} is not a valid status" }

  private

  # 商品の価格を注文にセットする
  def set_price_from_product
    self.price = product.price if product.present?
  end
end