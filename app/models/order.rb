class Order < ApplicationRecord
  belongs_to :user
  belongs_to :product
  has_one :shipping_address, dependent: :destroy

  before_create :set_price_from_product

  validates :status, presence: true, inclusion: { in: ['pending', 'completed', 'shipped', 'canceled'], message: "%{value} is not a valid status" }

  private

  def set_price_from_product
    self.price = product.price if product.present?
  end
end