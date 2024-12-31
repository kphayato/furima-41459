class OrderAddressForm
  include ActiveModel::Model

  # 必要な属性を定義
  attr_accessor :user_id, :item_id, :postal_code, :prefecture_id, :city, :street_address, :building_name, :phone_number, :token

  # バリデーション
  with_options presence: true do
    validates :user_id
    validates :item_id
    validates :postal_code, format: { with: /\A\d{3}-\d{4}\z/, message: "is invalid. Enter it as 123-4567" }
    validates :prefecture_id, numericality: { other_than: 1, message: "can't be blank" }
    validates :city
    validates :street_address
    validates :phone_number, format: { with: /\A\d{10,11}\z/, message: "is invalid. Enter a 10-11 digit number" }
    validates :token
  end

  def save
    # 購入情報を保存
    order = Order.create(user_id: user_id, item_id: item_id)
    puts order.errors.full_messages # エラーメッセージを確認
  
    # 発送先情報を保存
    address = Address.create(
      postal_code: postal_code,
      prefecture_id: prefecture_id,
      city: city,
      street_address: street_address,
      building_name: building_name,
      phone_number: phone_number,
      order_id: order.id
    )
    puts address.errors.full_messages # エラーメッセージを確認
  end
end