require 'rails_helper'

RSpec.feature "Homes", type: :feature do
  scenario "アクセスした際にリンクがある" do
      visit root_path
      expect(page).to have_link "投稿する"
    end
  end
