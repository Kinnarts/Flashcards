require "faker"
FactoryGirl.define do
  factory :user do
    email Faker::Lorem.word
    password Faker::Lorem.word
  end
end
