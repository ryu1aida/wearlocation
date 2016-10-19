class PostsController < ApplicationController

def index
  @posts = Post.all
end

def new
 @posts = Post.new
end


def show
   @posts = Post.all
end

def create
  Post.create(title: params[:name], image: params[:image], content: params[:text])
end

private
  def posts_params
    params.require(:posts).permit(:name, :image,:content)
  end


end
