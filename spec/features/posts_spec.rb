require 'rails_helper'

RSpec.feature "Posts", type: :feature do
  given!(:user) { create(:user) }

  background do
    sign_in user
  end

  scenario "投稿成功" do
    visit new_post_path
    fill_in "Compose new post...", with: "hello!"
    attach_file "post[picture]", "#{Rails.root}/spec/files/kabigon.png"
    click_on "Post"
    expect(page).to have_content "Post created!"
  end

  scenario "投稿失敗（コメントなしで投稿）" do
    visit new_post_path
    click_on "Post"
    expect(page).to have_content "Oops... you failed to post"
  end
end
