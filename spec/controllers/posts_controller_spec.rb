require 'rails_helper'

RSpec.describe PostsController, type: :controller do
  describe "#show" do
    let!(:user) { create(:user) }
    let!(:post) { create(:post, user: user) }

    before do
      get :show, params: { id: post.id }
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

    it "@postが期待される値をもつ" do
      expect(assigns(:post)).not_to match_array post
    end
  end

  describe "#new" do
    let!(:user) { create(:user) }
    let!(:post) { create(:post, user: user) }

    context "ログイン済みのユーザー" do
      before do
        sign_in user
        get :new
      end

      it "正常にレスポンスを返す" do
        expect(response).to be_successful
      end

      it "200レスポンスを返す" do
        expect(response).to have_http_status "200"
      end

      it "indexテンプレートを表示させる" do
        expect(response).to render_template :new
      end

      it "@postが期待される値をもつ" do
        expect(assigns(:post)).not_to match_array post
      end
    end

    context "ログインしていないユーザー" do
      before do
        get :new
      end

      it "レスポンスに失敗する" do
        expect(response).not_to be_successful
      end

      it "200レスポンスを返さない" do
        expect(response).not_to have_http_status "200"
      end

      it "indexテンプレートを表示できない" do
        expect(response).not_to render_template :new
      end

      it "@postが期待される値をもつ" do
        expect(assigns(:post)).not_to match_array post
      end
    end
  end

  describe "POST #create" do
    let!(:user) { create(:user) }
    let!(:post_attributes) { attributes_for(:post) }
    let!(:picture_path) { File.join(Rails.root, 'spec/files/kabigon.png') }
    let!(:picture) { Rack::Test::UploadedFile.new(picture_path) }

    context "ログイン済みのユーザー" do
      before do
        sign_in user
      end

      it "302レスポンスを返す" do
        post :create, params: { post: post_attributes }
        expect(response).to have_http_status "302"
      end

      it "投稿成功後、トップページへ" do
        post :create, params: { post: post_attributes }
        expect(response).to redirect_to root_path
      end

      it 'userを削除すると、userが投稿したpostも削除される' do
        user.posts.create(content: 'あとで書く', picture: picture)
        expect { user.destroy }.to change { Post.count }.by(-1)
      end
    end

    context "ログインしていないユーザー" do
      it "レスポンスが失敗する" do
        post :create, params: { post: post_attributes }
        expect(response).not_to be_successful
      end

      it "ログインしていないユーザーは投稿できない" do
        post :create, params: { post: post_attributes }
        expect(response).to redirect_to new_user_session_path
      end
    end
  end

  describe "DELETE #destroy" do
    let!(:user) { create(:user) }
    let!(:post) { create(:post, user: user) }

    context "ログイン済みのユーザー" do
      before do
        sign_in user
      end

      it '投稿を消去する' do
        expect do
          delete :destroy, params: { id: post.id }
        end.to change(Post, :count).by(-1)
      end

      it "302レスポンスを返す" do
        delete :destroy, params: { id: post.id }
        expect(response).to have_http_status "302"
      end

      it "投稿削除成功後、トップページかユーザー個別ページへ" do
        delete :destroy, params: { id: post.id }
        expect(response).to redirect_to root_path || users_path(user)
      end
    end

    context "ログインしていないユーザー" do
      it "レスポンスが失敗する" do
        delete :destroy, params: { id: post.id }
        expect(response).not_to be_successful
      end

      it "ログインしていないユーザーは投稿を削除できない" do
        delete :destroy, params: { id: post.id }
        expect(response).to redirect_to new_user_session_path
      end
    end
  end
end
