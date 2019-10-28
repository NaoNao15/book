class HomeController < ApplicationController
  def index
    if params[:q]
      @search = Post.ransack(params[:q])
      @posts = @search.result.order(created_at: :desc).paginate(page: params[:page], per_page: 10)
      @like_trend_posts = @search.result.joins("left join likes on posts.id = likes.post_id").group("posts.id").order(Arel.sql("count(likes.id) desc")).paginate(page: params[:page], per_page: 10)
      @stock_trend_posts = @search.result.joins("left join stockposts on posts.id = stockposts.post_id").group("posts.id").order(Arel.sql("count(stockposts.id) desc")).paginate(page: params[:page], per_page: 10)
    else
      @posts = Post.all.paginate(page: params[:page], per_page: 6).order(created_at: :desc)
      # Likeが多い順に入れ替えて代入
      @like_trend_posts = Post.joins("left join likes on posts.id = likes.post_id").group("posts.id").order(Arel.sql("count(likes.id) desc")).paginate(page: params[:page], per_page: 6)
      # Stockpostが多い順に入れ替えて代入
      @stock_trend_posts = Post.joins("left join stockposts on posts.id = stockposts.post_id").group("posts.id").order(Arel.sql("count(stockposts.id) desc")).paginate(page: params[:page], per_page: 6)
    end
  end
end
