require "faker"
FactoryGirl.define do
  factory :card do
    original_text Faker::Lorem.word
    translated_text Faker::Lorem.word
    review_date Time.now + 3.days
  end
end
