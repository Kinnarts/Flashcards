require "faker"
FactoryGirl.define do
  factory :card do
    original_text Faker::Lorem.word
    translated_text Faker::Lorem.sentence(word_count = 1)
    review_date Time.now + 3.days
    association :user
  end
end
