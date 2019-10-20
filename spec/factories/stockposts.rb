FactoryBot.define do
  factory :stockpost do
    association :user
    association :post
  end
end
