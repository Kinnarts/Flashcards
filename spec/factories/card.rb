FactoryGirl.define do

  factory :card do
    original_text "factory"
    translated_text "фабрика"
    review_date Time.now - 3.days
  end
end
