FactoryBot.define do
  factory :item do
    name { "テスト商品" }
    description { "これはテスト商品です" }
    category_id { 2 }
    condition_id { 2 }
    shipping_fee_id { 2 }
    prefecture_id { 2 }
    shipping_days_id { 2 }
    price { 1000 }
    association :user
  end
end