class OrderAddressForm
  include ActiveModel::Model

  # 必要な属性を定義
  attr_accessor :user_id, :item_id, :postal_code, :prefecture_id, :city, :street_address, :building_name, :phone_number, :token

  # バリデーション
  validates :user_id, :item_id, :postal_code, :prefecture_id, :city, :street_address, :phone_number, :token, presence: true

  def save
    # 1. 購入情報を保存 (Order)
    order = Order.new(user_id: user_id, item_id: item_id)
    return false unless order.save

    # 2. 発送先情報を保存 (ShippingAddress)
    address = ShippingAddress.new(
      postal_code: postal_code,
      prefecture_id: prefecture_id,
      city: city,
      street_address: street_address,
      building_name: building_name,
      phone_number: phone_number,
      order_id: order.id
    )

    return false unless address.save

    true
  end
end