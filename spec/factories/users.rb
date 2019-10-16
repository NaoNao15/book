FactoryBot.define do
  factory :user do
    sequence(:name) { |n| "User_#{n}" }
    sequence(:email) { |n| "tester#{n}@example.com" }
    password "foobar"
    password_confirmation "foobar"
  end
end
