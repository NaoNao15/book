require 'rails_helper'

RSpec.feature "Users", type: :feature do
  given!(:user) { create(:user) }
  given!(:other_user) { create(:user) }

  scenario "ユーザー情報があるか（ログイン済みの場合）" do
    sign_in user
    visit user_path(user)
    expect(page).to have_content user.name
    expect(page).to have_link 'Edit your profile'
  end

  scenario "ユーザー情報があるか（ログインしていないの場合）" do
    visit user_path(other_user)
    expect(page).to have_content other_user.name
  end

  scenario "自分のユーザーページへ行きプロフィール情報の変更" do
    sign_in user
    visit user_path(user)
    click_on "Edit your profile"
    fill_in "Name", with: "myname"
    fill_in "Email", with: "hogehoge@example.com"
    fill_in "Current password", with: "foobar"
    click_on "Update"
    expect(page).to have_content "Your account has been updated successfully."
  end
end
