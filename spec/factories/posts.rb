FactoryBot.define do
  factory :post do
    sequence(:content) { |n| "hello#{}" }
    association :user
  end
end
