require 'rails_helper'

RSpec.describe LikesController, type: :controller do
  let!(:user) { create(:user) }
  let!(:post1) { create(:post, user: user) }

  describe "#create" do
    context "ログイン済みのユーザー" do
      before do
        sign_in user
      end

      it "正常にレスポンスを返す" do
        post :create, format: :js, params: { post_id: post1.id }
        expect(response).to be_successful
      end

      it "200レスポンスを返す" do
        post :create, format: :js, params: { post_id: post1.id }
        expect(response).to have_http_status 200
      end

      it "いいねに成功する" do
        expect { post :create, format: :js, params: { post_id: post1.id } }.to change(Like, :count).by(1)
      end

      it "Ajaxが反応する" do
        post :create, format: :js, params: { post_id: post1.id }
        expect(response.content_type).to eq 'text/javascript'
      end
    end

    context "ログインしていないユーザー" do
      it "正常にレスポンスを返す" do
        post :create, format: :js, params: { post_id: post1.id }
        expect(response).not_to be_successful
      end

      it "401レスポンスを返す" do
        post :create, format: :js, params: { post_id: post1.id }
        expect(response).to have_http_status 401
      end

      it "いいねに失敗する" do
        expect { post :create, format: :js, params: { post_id: post1.id } }.to change(Like, :count).by(0)
      end
    end
  end

  describe "#destroy" do
    let!(:like) { create(:like, user_id: user.id, post_id: post1.id) }

    context "ログイン済みのユーザー" do
      before do
        sign_in user
      end

      it "レスポンスが成功する" do
        delete :destroy, format: :js, params: { post_id: post1.id, user_id: user.id, id: like.id }
        expect(response).to be_successful
      end

      it "200レスポンスを返す" do
        delete :destroy, format: :js, params: { post_id: post1.id, user_id: user.id, id: like.id }
        expect(response).to have_http_status 200
      end

      it "Ajaxが反応する" do
        delete :destroy, format: :js, params: { post_id: post1.id, user_id: user.id, id: like.id }
        expect(response.content_type).to eq 'text/javascript'
      end

      it "いいねの削除に成功する" do
        expect { delete :destroy, format: :js, params: { post_id: post1.id, user_id: user.id, id: like.id } }.to change(Like, :count).by(-1)
      end
    end

    context "ログインしていないユーザー" do
      before do
        delete :destroy, format: :js, params: { post_id: post1.id, user_id: user.id, id: like.id }
      end

      it "レスポンスが失敗する" do
        expect(response).not_to be_successful
      end

      it "401レスポンスを返す" do
        expect(response).to have_http_status 401
      end

      it "いいねの削除に失敗する" do
        expect { delete :destroy, format: :js, params: { post_id: post1.id, user_id: user.id, id: like.id } }.to change(Like, :count).by(0)
      end
    end
  end
end
