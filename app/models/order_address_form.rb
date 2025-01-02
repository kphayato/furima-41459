class OrderAddressForm
  include ActiveModel::Model

  attr_accessor :user_id, :item_id, :postal_code, :prefecture_id, :city, :street_address, :building_name, :phone_number, :token, :expiry_date, :cvc

  # バリデーション
  validates :user_id, :item_id, :postal_code, :prefecture_id, :city, :street_address, :phone_number, :token, presence: true
  validates :expiry_date, :cvc, presence: true, if: :requires_card_info?

  # 保存メソッド
  def save
    return false unless valid?

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

  private

  def requires_card_info?
    # 条件に応じてカード情報が必要かを判定
    true
  end
end