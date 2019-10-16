require 'rails_helper'

RSpec.feature "Homes", type: :feature do
  scenario "アクセスした際にリンクがある" do
    visit root_path
    expect(page).to have_link "投稿する"
    expect(page).to have_link "新規投稿"
  end

  scenario "ログインしていないユーザーが投稿しようとするとログイン画面へ" do
    visit root_path
    click_on "投稿する"
    expect(page).to have_content "メールアドレス"
    expect(page).to have_content "パスワード"
    expect(page).to have_content "パスワードを記憶する"
    expect(page).to have_button "ログイン"
  end
end
