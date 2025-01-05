class OrderAddressForm
  include ActiveModel::Model

  attr_accessor :user_id, :item_id, :postal_code, :prefecture_id, :city, :street_address, :building_name, :phone_number, :token

  # バリデーション
  validates :user_id, :item_id, :postal_code, :prefecture_id, :city,
            :street_address, :phone_number, :token, presence: true
  validates :postal_code, presence: true, format: { with: /\A\d{3}-\d{4}\z/, message: 'is invalid' }
  validates :phone_number, format: { with: /\A\d{10,11}\z/, message: 'is invalid. Enter 10-11 digits.' }
  validates :prefecture_id, numericality: { other_than: 1, message: 'must be selected' }

  def save
    Rails.logger.debug "OrderAddressForm#save called with attributes: #{self.inspect}"

    return false unless valid?

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
    end

    true
  rescue StandardError => e
    Rails.logger.error "OrderAddressForm#save failed: #{e.message}"
    false
  end
end