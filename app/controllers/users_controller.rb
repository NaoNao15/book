class UsersController < ApplicationController
  def index
    @users = User.paginate(page: params[:page], per_page: 5)
  end

  def show
    @user = User.find(params[:id])
    @posts = @user.posts.paginate(page: params[:page])
  end
end

private

 def correct_user
   @user = User.find(params[:id])
   redirect_to(root_url) unless current_user?(@user)
 end
