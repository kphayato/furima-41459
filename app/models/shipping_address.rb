class ShippingAddress < ApplicationRecord
  belongs_to :order

  # street_addressに数字とハイフンのみを許可
  validates :street_address, presence: true, format: { with: /\A[0-9ー-]+\z/, message: "is invalid" }
  validates :postal_code, presence: true, format: { with: /\A\d{3}-\d{4}\z/, message: "is invalid" }
  validates :phone_number, presence: true, length: { minimum: 10, maximum: 11, message: "is too short (minimum is 10 characters)" }
  validates :city, presence: true
  validates :prefecture_id, presence: true
end