FactoryBot.define do
  factory :user do
    name { Faker::Internet.username }
    password_digest { BCrypt::Password.create('123qweasd') }
    sequence(:email) { |n| "example#{n}@gmail.com" }
  end
end
