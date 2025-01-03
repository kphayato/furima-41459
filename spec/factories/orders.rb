FactoryBot.define do
  factory :order do
    association :user
    association :item
    status { "pending" }
  end
end