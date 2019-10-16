require 'rails_helper'

RSpec.describe HomeController, type: :controller do
  describe "indexページ表示" do
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
  end
end
