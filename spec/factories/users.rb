FactoryBot.define do
  factory :user do
    nickname              { "TestUser" }
    email                 { Faker::Internet.email }
    password              { "password123" }
    password_confirmation { "password123" }
    first_name            { "太郎" }
    last_name             { "山田" }
    first_name_kana       { "タロウ" }
    last_name_kana        { "ヤマダ" }
    birth_date            { "1990-01-01" }
  end
end