class CommentsController < ApplicationController

  def new
     @post = Post.find(params[:post_id])
     @comment = Comment.new
     @comment.post_id = @post.id
   end

   def create
    @comment = Comment.create(create_params)
  end

  private
  def create_params
    params.require(:comment).permit(:post_id, :text).merge(user_id: current_user.id)
  end


end
