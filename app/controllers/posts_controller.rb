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
    @images = Post.within(1, :units => :kms, :origin => @post)
      @hash = Gmaps4rails.build_markers(@post) do |cicada, marker|
        marker.lat cicada.latitude
        marker.lng cicada.longitude
        marker.infowindow cicada.gmaps4rails_infowindow
        marker.picture({
                    # :url => @hashimage,
                    :width   => 30,
                    :height  => 30
                   })
       # marker.json({ title: cicada.title })
      end
      @hashimage = Gmaps4rails.build_markers(@images) do |cicada, marker|
      marker.lat cicada.latitude
      marker.lng cicada.longitude
      marker.infowindow cicada.gmaps4rails_infowindow
      end
  end

  def create
    redirect_to action: :index
    exif = EXIFR::JPEG::new(post_params[:image].tempfile).to_hash
    latitude = exif.to_hash[:gps_latitude]
    latitude = latitude[0] + latitude[1]/60 + latitude[2]/3600.to_f
    longitude = exif.to_hash[:gps_longitude]
    longitude = longitude[0] + longitude[1]/60 + longitude[2]/3600.to_f
    address = latitude.to_s + "," + longitude.to_s
    description = Geocoder.address(address, language: :ja)
    post_params = params.require(:post)
          .permit(:title, :image, :content,:profile, [:tag_list]).merge(longitude: longitude, latitude: latitude, description: description)
    post = current_user.posts.create(post_params)
    tags = params[:tag_list].split(",")
      tags.each do |t|
      post.tag_list.add(t)
      end
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
