class Address < ApplicationRecord
  belongs_to :order

  # バリデーションを追加
  validates :order, presence: true
end