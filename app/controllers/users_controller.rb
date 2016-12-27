class UsersController < ApplicationController
  def show
    @nickname = current_user.nickname
    @posts = current_user.posts.page(params[:page]).per(5).order("created_at DESC")
  end

  def create
    @user = User.new(user_params)
    #画像ファイル取得
    user.profile(params[:profile])
  end


private
  def user_params
    params.require(:user).permit(:profile)
  end



end
