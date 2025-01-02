class ShippingAddress < ApplicationRecord
  belongs_to :order

  # Prefectureモデルから都度都道府県の名前を取得
  def prefecture_name
    Prefecture.find_by(id: self.prefecture_id)&.name
  end
end