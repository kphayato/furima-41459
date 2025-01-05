FactoryBot.define do
  factory :order do
    association :user
    association :item
    token {"tok_abcdefghijk00000000000000000"}

    item_id { 1 }
    user_id { 1 }

  end
end