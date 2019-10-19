require 'rails_helper'

RSpec.describe LikesController, type: :controller do
  xdescribe "#create" do
    let!(:user) { create(:user) }
    let!(:post) { create(:post, user: user) }
    # let(:like) { create(:like, user_id: user.id, post_id: post.id) }

    context "ログイン済みのユーザー" do
      before do
        sign_in user
      end

      it "Ajexが反応する" do
        post :create, format: :js, params: { post_id: post.id }
        expect(response.content_type).to eq 'text/javascript'
      end
    end
  end
end
