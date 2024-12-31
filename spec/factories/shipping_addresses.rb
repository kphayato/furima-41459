FactoryBot.define do
  factory :shipping_address do
    order { nil }
    postal_code { "MyString" }
    prefecture { "MyString" }
    city { "MyString" }
    house_number { "MyString" }
    building_name { "MyString" }
  end
end
