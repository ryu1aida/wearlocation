class CommentsController < ApplicationController

    def index
      @comments = Comment.all
      @comment = Comment.new
    end

    def new
       @comment = Comment.new
     end

     def show
       @comment = Comment.find(params[:id])
     end

     def create
       Comment.create(create_params)
       @comment = Comment.new
       @post = Post.find(params[:comment][:post_id])
    end

    private
    def create_params
      params.require(:comment).permit(:post_id, :text).merge(user_id: current_user.id)
    end



end
