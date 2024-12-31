class Address
  include ActiveModel::Model
  attr_accessor :user_id, :item_id, :postal_code, :prefecture_id, :city, :address, :building, :phone_number, :token

  # バリデーション
  with_options presence: true do
    validates :user_id
    validates :item_id
    validates :postal_code, format: { with: /\A\d{3}-\d{4}\z/, message: "is invalid. Enter it as 123-4567" }
    validates :prefecture_id, numericality: { other_than: 1, message: "can't be blank" } # 1は未選択状態のIDを想定
    validates :city
    validates :address
    validates :phone_number, format: { with: /\A\d{10,11}\z/, message: "is invalid. Enter a 10-11 digit number" }
    validates :token
  end

  validates :phone_number, numericality: { only_integer: true, message: "is invalid. Input only numbers" }
end