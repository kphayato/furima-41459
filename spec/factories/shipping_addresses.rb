# spec/factories/shipping_addresses.rb
FactoryBot.define do
  factory :shipping_address do
    postal_code { '123-4567' }
    city { '横浜市' }
    street_address { '1-1-1' }  # 正しい住所
    phone_number { '09012345678' }
    prefecture_id { 1 }
    association :order

    # 無効な住所を作成する場合
    trait :invalid_address do
      street_address { '12345' }  # 無効な住所
    end
  end
end