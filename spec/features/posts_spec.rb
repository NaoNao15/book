require 'rails_helper'

RSpec.feature "Posts", type: :feature do
  given!(:user) { create(:user) }

  background do
    sign_in user
  end

  scenario "投稿成功" do
    visit new_post_path
    fill_in "About your important book...", with: "hello!"
    attach_file "post[picture]", "#{Rails.root}/spec/files/kabigon.png"
    click_on "Post"
    expect(page).to have_content "Post created!"
  end

  scenario "投稿失敗（コメントなしで投稿）" do
    visit new_post_path
    click_on "Post"
    expect(page).to have_content "Oops... you failed to post"
  end

  scenario "投稿後、その投稿を削除する" do
    visit new_post_path
    fill_in "About your important book...", with: "hello!"
    attach_file "post[picture]", "#{Rails.root}/spec/files/kabigon.png"
    click_on "Post"
    expect(page).to have_content "Post created!"
    find('#delete_image').click
    expect(page).to have_content "Post deleted!"
  end

  scenario "投稿後、その記事の詳細画面へ移行することができる" do
    visit new_post_path
    fill_in "About your important book...", with: "hello!"
    attach_file "post[picture]", "#{Rails.root}/spec/files/kabigon.png"
    click_on "Post"
    expect(page).to have_content "Post created!"
    find('#post_image').click
    expect(page).to have_css '.timestamp'
    expect(page).to have_css '.user'
    expect(page).to have_css '.content'
  end
end
