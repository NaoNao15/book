require 'rails_helper'

RSpec.describe Comment, type: :model do
  it "コメントが有効" do
    expect(build(:comment)).to be_valid
  end

  it "空コメントは無効" do
    comment = build(:comment, content: nil)
    comment.valid?
    expect(comment.errors[:content]).to include("can't be blank")
  end

  it "コメントが61文字以上は無効" do
    comment = build(:comment, content: "a" * 61)
    comment.valid?
    expect(comment.errors[:content]).to include("is too long (maximum is 60 characters)")
  end
end
