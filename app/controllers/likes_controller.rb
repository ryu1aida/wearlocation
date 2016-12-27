class LikesController < ApplicationController
  def create
    Like.create(user_id: current_user.id, post_id: params[:post_id])
    @post = Post.find(params[:post_id])
  end

  def destroy
    @post = Post.find(params[:post_id])
    like = Like.find_by(user_id: current_user.id, post_id: params[:post_id])
    like.destroy
  end

end
