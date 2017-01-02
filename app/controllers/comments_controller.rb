class CommentsController < ApplicationController

  def index
    @comments = Comment.all
  end

  def new
     @comment = Comment.new
   end

   def show
     @comment = Comment.find(params[:id])
   end

   def create
     comment = current_user.comment.create(create_params)
  end

  private
  def create_params
    params.require(:comment).permit(:post_id, :text).merge(user_id: current_user.id)
  end


end
