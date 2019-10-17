class HomeController < ApplicationController
  def index
    @posts = Post.all.order(created_at: :desc).paginate(page: params[:page])
    # @feed_items = current_user.feed.paginate(page: params[:page])
  end
end
