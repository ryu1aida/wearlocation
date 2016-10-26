class PostsController < ApplicationController

def index
  @posts = Post.order("created_at DESC").page(params[:page]).per(5)
end

def new
 @post = Post.new
end


def show
  @post = Post.find(params[:id])
end

def create
  Post.create(title: post_params[:title], image: tweet_params[:image], content: tweet_params[:content], user_id: current_user.id)
end

private
  def post_params
    params.require(:post).permit(:title, :image, :content)
  end

end
