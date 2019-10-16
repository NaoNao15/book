require 'rails_helper'

RSpec.describe User, type: :model do
  it "名前、メールアドレス、パスワードがあれば有効であること" do
    expect(build(:user)).to be_valid
  end

  it "名前がなければ無効な状態であること" do
    user = build(:user, name: nil)
    user.valid?
    expect(user.errors[:name]).to include("can't be blank")
  end

  it "メールアドレスがなければ無効な状態であること" do
    user = build(:user, email: nil)
    user.valid?
    expect(user.errors[:email]).to include("can't be blank")
  end

  it "パスワードがなければ無効な状態であること" do
    user = build(:user, password: nil)
    user.valid?
    expect(user.errors[:password]).to include("can't be blank")
  end

  it "重複したメールアドレスなら無効な状態であること" do
    create(:user, email: "taster@example.com")
    user = build(:user, email: "taster@example.com")
    user.valid?
    expect(user.errors[:email]).to include("has already been taken")
  end
end
