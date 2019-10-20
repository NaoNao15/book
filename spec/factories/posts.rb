FactoryBot.define do
  factory :post do
    sequence(:content) { |n| "hello#{n}" }
    picture { Rack::Test::UploadedFile.new(File.join(Rails.root, 'spec/files/kabigon.png')) }
    association :user
  end
end
