class PostsController < ApplicationController
  # layout 'ranking_site'
  before_action :ranking
  before_action :set_article_tags_to_gon, only: :edit
  before_action :set_available_tags_to_gon, only: [:new, :edit]



  def index
    @posts = Post.includes(:user).page(params[:page]).per(5).order("created_at DESC")
    @comment = Comment.new
  end

  def new
   @post = Post.new
  end

  def show
    @post = Post.find(params[:id])
    @hash = Gmaps4rails.build_markers(@post) do |cicada, marker|
     marker.lat cicada.latitude
     marker.lng cicada.longitude
    #  marker.infowindow cicada.address
    #  marker.json({title: cicada.title})
    end
  end

  def create

    redirect_to action: :index
    post = current_user.posts.create(post_params)
    tags = params[:tag_list].split(",")
      tags.each do |t|
      post.tag_list.add(t)
      end
      post.save
    # t = MiniExiftool.new
    # t.to_hash

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
    @ranking = Post.order('likes_count DESC').limit(5)
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
            .permit(:title, :image, :content,:profile, [:tag_list])
    end
end
