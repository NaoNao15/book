class StockpostsController < ApplicationController
  before_action :set_post

  def create
    @stockpost = Stockpost.create(user_id: current_user.id, post_id: params[:post_id])
    @stockposts = Stockpost.where(post_id: params[:post_id])
    @post.reload
  end

  def destroy
    stockpost = Stockpost.find_by(user_id: current_user.id, post_id: params[:post_id])
    stockpost.destroy
    @stockposts = Stockpost.where(post_id: params[:post_id])
    @post.reload
  end

  private

  def set_post
    @post = Post.find(params[:post_id])
  end

end
