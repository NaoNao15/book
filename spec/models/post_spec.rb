require 'rails_helper'

RSpec.describe Post, type: :model do
  it "投稿が有効" do
    expect(build(:post)).to be_valid
  end

  it "140文字以上の投稿はできない" do
    post = build(:post, content: "a" * 141)
    post.valid?
    expect(post.errors[:content]).to include("is too long (maximum is 140 characters)")
  end

  it "contentがない場合は投稿ができない" do
    post = build(:post, content: nil)
    post.valid?
    expect(post.errors[:content]).to include("can't be blank")
  end

  it "pictureがない場合は投稿ができない" do
    post = build(:post, picture: nil)
    post.valid?
    expect(post.errors[:picture]).to include("can't be blank")
  end
end
