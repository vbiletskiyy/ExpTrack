FactoryBot.define do
  factory :user_spending do
    user
    sent { true }
    spending
  end
end
