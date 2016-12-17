class RenameTweetIdColumnToLikes < ActiveRecord::Migration
  def change
    rename_column :likes, :tweet_id, :post_id
  end
end
