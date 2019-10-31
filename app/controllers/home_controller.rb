class HomeController < ApplicationController
  def index
    if params[:q]
      @search = Post.ransack(params[:q])
      @posts = @search.result.order(created_at: :desc).paginate(page: params[:page], per_page: 10)
      @like_trend_posts = @search.result.like_trend_sql.paginate(page: params[:page], per_page: 10)
      @stock_trend_posts = @search.result.stock_trend_sql.paginate(page: params[:page], per_page: 10)
    else
      @posts = Post.all.paginate(page: params[:page], per_page: 10).order(created_at: :desc)
      # Likeが多い順に入れ替えて代入
      @like_trend_posts = Post.like_trend_sql.paginate(page: params[:page], per_page: 10)
      # Stockpostが多い順に入れ替えて代入
      @stock_trend_posts = Post.stock_trend_sql.paginate(page: params[:page], per_page: 10)
    end
  end
end
