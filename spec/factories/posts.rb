FactoryBot.define do
  factory :post do
    sequence(:content) { |n| "hello#{n}" }
    association :user
  end
end
