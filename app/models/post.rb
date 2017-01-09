class Post < ActiveRecord::Base
  mount_uploader :image, ImageUploader
  belongs_to :user
  has_many :places
  has_many :likes, dependent: :destroy
  has_many :comments
  def like_user(user_id, post_id)
    Like.find_by(user_id: user_id, post_id: post_id)
  end
  # タグ機能の実装
  #  acts_as_taggable_on :protopype # post.label_list が追加される
   acts_as_taggable            # acts_as_taggable_on :tags のエイリアス
   acts_as_mappable default_units: :kms,
                    default_formula: :sphere,
                    distance_field_name: :distance,
                    lat_column_name: :latitude,
                    lng_column_name: :longitude
                    # geokitを動かすため
  # #  ジオコードにより緯度経度から住所を自動登録できるようにする
  # Geocoder.configure(language: :ja) #取得する言語を日本語にする
  # reverse_geocoded_by :latitude, :longitude  #緯度経度を取得した際に住所を取得する
  # after_validation :description  # 取得した住所をpostsテーブルのdescriptionカラムに保存したい
  # geocoded_by :latitude, :longitude
  def gmaps4rails_infowindow
      "<img src=\"#{self.image.url}\", height=300, width=300, class=\"image_popup\"><br>
        #{description}"
  end
end
