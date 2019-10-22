require 'rails_helper'

RSpec.describe StockpostsController, type: :controller do
  let!(:user) { create(:user) }
  let!(:post1) { create(:post, user: user) }

  describe "#create" do
    context "登録済みのユーザー" do
      before do
        sign_in user
      end

      it "レスポンスが成功する" do
        post :create, format: :js, params: { post_id: post1.id }
        expect(response).to be_successful
      end

      it "200レスポンスを返す" do
        post :create, format: :js, params: { post_id: post1.id }
        expect(response).to have_http_status 200
      end

      it "記事のストックに成功する" do
        expect { post :create, format: :js, params: { post_id: post1.id } }.to change(Stockpost, :count).by(1)
      end

      it "Ajaxが反応する" do
        post :create, format: :js, params: { post_id: post1.id }
        expect(response.content_type).to eq 'text/javascript'
      end
    end

    context "登録していないユーザー" do
      it "レスポンスが失敗する" do
        post :create, format: :js, params: { post_id: post1.id }
        expect(response).not_to be_successful
      end

      it "401レスポンスを返す" do
        post :create, format: :js, params: { post_id: post1.id }
        expect(response).to have_http_status 401
      end

      it "記事のストックに失敗する" do
        expect { post :create, format: :js, params: { post_id: post1.id } }.to change(Stockpost, :count).by(0)
      end
    end
  end

  describe "#destroy" do
    let!(:stockpost) { create(:stockpost, user_id: user.id, post_id: post1.id) }

    context "登録済みのユーザー" do
      before do
        sign_in user
      end

      it "レスポンスが成功する" do
        delete :destroy, format: :js, params: { post_id: post1.id, user_id: user.id, id: stockpost.id }
        expect(response).to be_successful
      end

      it "200レスポンスを返す" do
        delete :destroy, format: :js, params: { post_id: post1.id, user_id: user.id, id: stockpost.id }
        expect(response).to have_http_status 200
      end

      it "Ajaxが反応する" do
        delete :destroy, format: :js, params: { post_id: post1.id, user_id: user.id, id: stockpost.id }
        expect(response.content_type).to eq 'text/javascript'
      end

      it "記事のストックの削除に成功する" do
        expect { delete :destroy, format: :js, params: { post_id: post1.id, user_id: user.id, id: stockpost.id } }.to change(Stockpost, :count).by(-1)
      end
    end

    context "登録していないユーザー" do
      before do
        delete :destroy, format: :js, params: { post_id: post1.id, user_id: user.id, id: stockpost.id }
      end

      it "レスポンスが失敗する" do
        expect(response).not_to be_successful
      end

      it "401レスポンスを返す" do
        expect(response).to have_http_status 401
      end

      it "記事のストックの削除に失敗する" do
        expect { delete :destroy, format: :js, params: { post_id: post1.id, user_id: user.id, id: stockpost.id } }.to change(Stockpost, :count).by(0)
      end
    end
  end
end
