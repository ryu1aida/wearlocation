class CommentsController < ApplicationController

  def index
    @comments = Comment.all
    @comment = Comment.new
  end

  def new
     @comment = Comment.new
     @comment.post_id = @post.id
   end

   def show
     @comment = Comment.find(params[:id])
   end

   def create
     @comment = Comment.create(create_params)
  end

  private
  def create_params
    params.require(:comment).permit(:post_id, :text).merge(user_id: current_user.id)
  end


end
