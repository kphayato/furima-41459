FactoryBot.define do
  factory :user do
    nickname { 'test_user' }
    first_name { '太郎' }
    last_name { '山田' }
    first_name_kana { 'タロウ' }
    last_name_kana { 'ヤマダ' }
    birth_date { '1990-01-01' }
    password { 'password123' }
    email { Faker::Internet.email }
  end
end