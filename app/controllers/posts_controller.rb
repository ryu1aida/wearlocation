class PostsController < ApplicationController

  def index
    @posts = Post.includes(:user).page(params[:page]).per(5).order("created_at DESC")
    @places = Place.all
    @hash = Gmaps4rails.build_markers(@places) do |place, marker|
      marker.lat place.latitude
      marker.lng place.longitude
      marker.infowindow place.name
    end
  end

  def new
   @post = Post.new
   @place = Place.new
  end

  def show
    @post = Post.find(params[:id])
  end

  def create
    current_user.posts.create(post_params)
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
      params.require(:post)
            .permit(:title, :image, :content)
    end
end
