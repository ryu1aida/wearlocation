class AddPlacesToPosts < ActiveRecord::Migration
  def change
    add_column :posts, :name, :string
    add_column :posts, :description, :string
    add_column :posts,:latitude, :float
    add_column :posts,:longitude, :float
  end
end
