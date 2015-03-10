FactoryGirl.define do
  factory :pack do
    name "MyPack"
    association :user
  end
end
