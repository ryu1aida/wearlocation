class PostsController < ApplicationController
  # layout 'ranking_site'
  before_action :ranking
  before_action :set_article_tags_to_gon, only: :edit
  before_action :set_available_tags_to_gon, only: [:new, :edit]



  def index
    @posts = Post.includes(:user).page(params[:page]).per(5).order("created_at DESC")
    @hash = Gmaps4rails.build_markers(@places) do |place, marker|
      marker.lat place.latitude
      marker.lng place.longitude
      marker.infowindow place.name
    end

  end

  def new
   @post = Post.new
  end

  def show
    @post = Post.find(params[:id])
  end

  def create
    redirect_to action: :index
    post = current_user.posts.create(post_params)
    post.tag_list.add(params[:tag])
    # post.tag_list.add()タグを複数投稿できるようにしたい
    post.save

  end

  def destroy
    redirect_to action: :index
    post = Post.find(params[:id])
    if post.user_id == current_user.id
      post.destroy
    end
    post.tag_list.remove(params[:tag])
  end

  def edit
       @post = Post.find(params[:id])
       post.tag_list
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
            .permit(:title, :image, :content,:profile, [:tag])
    end
end
