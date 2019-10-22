FactoryBot.define do
  factory :comment do
    content "a"
    association :user
    association :post
  end
end
