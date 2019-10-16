require 'rails_helper'

RSpec.feature "Homes", type: :feature do
  scenario "アクセスした際にリンクがある" do
    visit root_path
    expect(page).to have_link "New post"
  end

  scenario "ログインしていないユーザーが投稿しようとするとログイン画面へ" do
    visit root_path
    click_on "New post"
    expect(page).to have_content "Email"
    expect(page).to have_content "Password"
    expect(page).to have_content "Remember me"
    expect(page).to have_button "Log in"
  end
end
