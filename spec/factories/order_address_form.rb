FactoryBot.define do
  factory :order_address_form do
    postal_code { '123-4567' }
    prefecture_id { 2 }
    city { 'Test City' }
    street_address { '123 Test Street' }
    building_name { 'Test Building' }
    phone_number { '09012345678' }
    token { 'tok_test123' }
  end
end