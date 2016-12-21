class PostsController < ApplicationController
  # layout 'ranking_site'
  before_action :ranking, only: :index
  before_action :set_article_tags_to_gon, only: [:edit]
  before_action :set_available_tags_to_gon, only: [:new, :edit]

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
    post = current_user.posts.create(post_params)
    post.tag_list.add(params[:tag])
    binding.pry
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

  def ranking
    post_ids = Post.group(:id).order('count_likes_count DESC').limit(5).count(:likes_count).keys
    @ranking = post_ids.map { |id| Post.find(id) }
  end

  def set_article_tags_to_gon
    gon.post_tags = @post.tag_list
  end

  def set_available_tags_to_gon
    gon.post_tags = Post.tags_on(:tags).pluck(:name)
  end


  private

    def post_params
      params.require(:post)
            .permit(:title, :image, :content, :tag)
    end
end
