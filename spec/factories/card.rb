require "faker"
FactoryGirl.define do
  factory :card do
    original_text Faker::Lorem.word
    translated_text Faker::Lorem.sentence(word_count = 1)
    review_date Time.now
    success_count_id 0
    error_count_id 0
    association :user
    association :pack
  end
end
