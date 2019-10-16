require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  let!(:user) { create(:user) }
  let!(:other_user) { create(:user) }

  describe "showページ表示" do
    before do
      get :show, params: { id: user.id }
    end

    it "正常にレスポンスを返す" do
      expect(response).to be_successful
    end

    it "200レスポンスを返す" do
      expect(response).to have_http_status "200"
    end

    it "showテンプレートを表示させる" do
      expect(response).to render_template :show
    end

    it "@userが期待される値をもつ" do
      expect(assigns(:user)).to eq user
    end
  end
end
