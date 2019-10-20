class PostsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create, :destroy]
  before_action :correct_user, only: :destroy

  def show
    @post = Post.find(params[:id])
  end

  def new
    @post = current_user.posts.build
  end

  def create
    @post = current_user.posts.build(post_params)
    if @post.save
      flash[:notice] = "Post created!"
      redirect_to root_url
    else
      flash.now[:notice] = "Oops... you failed to post"
      render 'posts/new'
    end
  end

  def destroy
    @post.destroy
    flash[:notice] = "Post deleted!"
    redirect_to root_url || request.referrer
  end

  private

  def post_params
    params.require(:post).permit(:content, :picture)
  end

  def correct_user
    @post = current_user.posts.find_by(id: params[:id])
    redirect_to root_url if @post.nil?
  end
end
