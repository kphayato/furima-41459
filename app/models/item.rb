class Item < ApplicationRecord
  belongs_to :user
  has_one_attached :image

  # ActiveHash関連
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :category
  belongs_to :condition
  belongs_to :shipping_fee
  belongs_to :prefecture
  belongs_to :shipping_days

  # バリデーション
  validates :name, :description, :image, presence: true
  validates :category_id, :condition_id, :shipping_fee_id, :prefecture_id, :shipping_days_id, numericality: { other_than: 1, message: "を選択してください" }
  validates :price, numericality: { only_integer: true, greater_than_or_equal_to: 300, less_than_or_equal_to: 9_999_999 }
end