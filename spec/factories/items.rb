FactoryBot.define do
  factory :item do
    name            { 'テスト商品' }
    description     { 'これはテスト商品です' }
    price           { 1000 }  # 数値を設定
    category_id     { 2 }
    condition_id    { 2 }
    shipping_fee_id { 2 }
    prefecture_id   { 2 }
    shipping_day_id { 2 }
    image           { Rack::Test::UploadedFile.new(Rails.root.join('spec/fixtures/files/test_image.jpg'), 'image/jpeg') }
    association:user
  end
end