require 'rails_helper'

RSpec.describe Like, type: :model do
  it "いいねが有効" do
    expect(build(:like)).to be_valid
  end
end
