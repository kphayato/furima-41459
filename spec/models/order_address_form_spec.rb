class OrderAddressForm
  include ActiveModel::Model

  attr_accessor :user_id, :item_id, :postal_code, :prefecture_id, :city, :street_address, :building_name, :phone_number, :token

  # バリデーション
  validates :user_id, :item_id, :postal_code, :prefecture_id, :city,
            :street_address, :phone_number, :token, presence: true
  validates :postal_code, format: { with: /\A\d{3}-\d{4}\z/, message: "is invalid. Include hyphen(-)." }
  validates :phone_number, presence: true, format: { with: /\A\d{11}\z/, message: 'is invalid. Enter exactly 11 digits.' }
  validates :prefecture_id, numericality: { other_than: 1, message: "is invalid. Select a valid prefecture." }

  def save
    Rails.logger.debug "OrderAddressForm#save called with attributes: #{attributes_for_debug.inspect}"

    unless valid?
      Rails.logger.debug "Validation failed: #{errors.full_messages}"
      return false
    end

    ActiveRecord::Base.transaction do
      order = Order.create!(user_id: user_id, item_id: item_id)
      Rails.logger.debug "Order created: #{order.inspect}"

      ShippingAddress.create!(
        postal_code: postal_code,
        prefecture_id: prefecture_id,
        city: city,
        street_address: street_address,
        building_name: building_name,
        phone_number: phone_number,
        order_id: order.id
      )
      Rails.logger.debug "ShippingAddress created successfully."
    end

    true
  rescue StandardError => e
    Rails.logger.error "OrderAddressForm#save failed: #{e.message}"
    false
  end

  private

  # デバッグ用の属性情報を整形
  def attributes_for_debug
    {
      user_id: user_id,
      item_id: item_id,
      postal_code: postal_code,
      prefecture_id: prefecture_id,
      city: city,
      street_address: street_address,
      building_name: building_name,
      phone_number: phone_number,
      token: token
    }
  end
end