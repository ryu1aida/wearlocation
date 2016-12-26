class Post < ActiveRecord::Base
  mount_uploader :image, ImageUploader
  belongs_to :user
  has_many :places
  has_many :likes, dependent: :destroy
  def like_user(user_id)
    likes.find_by(user_id: user_id)
  end
  # タグ機能の実装
   acts_as_taggable_on :tag # post.label_list が追加される
   acts_as_taggable            # acts_as_taggable_on :tags のエイリアス


end
