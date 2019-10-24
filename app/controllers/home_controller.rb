class HomeController < ApplicationController
  def index
    if params[:q]
      @search = Post.ransack(params[:q])
      @posts = @search.result.order(created_at: :desc).paginate(page: params[:page], per_page: 10)
    else
      @posts = Post.all.paginate(page: params[:page], per_page: 10)
    end
  end
end
