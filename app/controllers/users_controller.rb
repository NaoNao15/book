class UsersController < ApplicationController
  def index
    @users = User.paginate(page: params[:page], per_page: 8)
  end

  def show
    @user = User.find(params[:id])
    @posts = @user.posts.paginate(page: params[:page], per_page: 10)
    @like_posts = @user.likes.paginate(page: params[:page], per_page: 10)
    @stockposts = @user.stockposts.paginate(page: params[:page], per_page: 10)
  end

  def following
    @title = "Following"
    @user  = User.find(params[:id])
    @users = @user.following.paginate(page: params[:page], per_page: 10)
    render 'show_follow'
  end

  def followers
    @title = "Followers"
    @user  = User.find(params[:id])
    @users = @user.followers.paginate(page: params[:page], per_page: 10)
    render 'show_follow'
  end
end
