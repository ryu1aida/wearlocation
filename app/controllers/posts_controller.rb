class PostsController < ApplicationController

def index
  @posts = Post.includes(:user).page(params[:page]).per(5).order("created_at DESC")
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

def destroy
      post = Post.find(params[:id])
      if post.user_id == current_user.id
        post.destroy
      end
end

def edit
     @post = Post.find(params[:id])
end

def update
      post = Post.find(params[:id])
      if post.user_id == current_user.id
        post.update(post_params)
      end
    end


private
  def post_params
    params.require(:post).permit(:title, :image)
  end

end
