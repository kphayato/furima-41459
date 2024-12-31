class ShippingAddress < ApplicationRecord
  belongs_to :order

  validates :postal_code, presence: true, format: { with: /\A\d{3}-\d{4}\z/, message: "must be in the format xxx-xxxx" }
  validates :prefecture, presence: true
  validates :city, presence: true
  validates :house_number, presence: true
end