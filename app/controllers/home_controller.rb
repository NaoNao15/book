class HomeController < ApplicationController
  def index
    if params[:q]
      @search = Post.ransack(params[:q])
      @posts = @search.result.order(created_at: :desc).paginate(page: params[:page], per_page: 10)
      @trend_posts = @search.result.order(created_at: :desc).paginate(page: params[:page], per_page: 10)
    else
      @posts = Post.all.paginate(page: params[:page], per_page: 10).order(created_at: :desc)
      @trend_posts = Post.joins("left join likes on posts.id = likes.post_id").group("posts.id").order(Arel.sql("count(likes.id) desc"))
    end
  end
end
