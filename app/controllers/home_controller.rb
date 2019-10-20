class HomeController < ApplicationController
  def index
    @posts = Post.all.order(created_at: :desc).paginate(page: params[:page])
  end
end
