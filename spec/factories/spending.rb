FactoryBot.define do
  factory :spending do
    amount { Faker::Commerce.price }
    description { Faker::Commerce.product_name }
    spending_category
  end
end
