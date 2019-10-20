require 'rails_helper'

RSpec.describe Stockpost, type: :model do
  it "ストックポストが有効" do
    expect(build(:stockpost)).to be_valid
  end
end
