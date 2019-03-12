FactoryBot.define do
  factory :item do
    merchant
    sequence(:name) {|n| "Item #{n}"}
    description { "MyText" }
    unit_price { 1 }
  end
end
