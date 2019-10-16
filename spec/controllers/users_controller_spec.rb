require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  let!(:user) { create(:user) }
  let!(:other_user) { create(:user) }

  describe "indexページ表示" do
    context "ログイン済みのユーザー" do
      before do
        sign_in user
        get :index
      end

      it "正常にレスポンスを返す" do
        expect(response).to be_successful
      end

      it "200レスポンスを返す" do
        expect(response).to have_http_status "200"
      end

      it "indexテンプレートを表示させる" do
        expect(response).to render_template :index
      end

      it "@usersが期待される値をもつ" do
        expect(assigns(:users)).to include user
      end
    end

    context "ログインしていないユーザー" do
      before do
        get :index
      end

      it "正常にレスポンスを返す" do
        expect(response).to be_successful
      end

      it "200レスポンスを返す" do
        expect(response).to have_http_status "200"
      end

      it "indexテンプレートを表示させる" do
        expect(response).to render_template :index
      end

      it "@usersが期待される値をもつ" do
        expect(assigns(:users)).to include user
      end
    end
  end

  describe "showページ表示" do
    context "ログイン済みのユーザー" do
      before do
        sign_in user
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

    context "ログインしていないユーザー" do
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
end
