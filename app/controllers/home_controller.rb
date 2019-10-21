class HomeController < ApplicationController
  def index
    if params[:q]
      @search = Post.ransack(params[:q])
      @posts = @search.result.order(created_at: :desc).
               paginate(page:params[:page])
    else
      @posts = Post.all.order(created_at: :desc).paginate(page: params[:page])
    end
  end
end
