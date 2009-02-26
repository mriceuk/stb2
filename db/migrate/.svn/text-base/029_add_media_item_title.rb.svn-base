class AddMediaItemTitle < ActiveRecord::Migration
  def self.up
    add_column :media_items, :title, :string
    add_column :media_items, :thumbnail, :string
    add_column :media_items, :width, :string
    add_column :media_items, :height, :string
    add_column :media_items, :playing_square_id, :integer
  end

  def self.down
    remove_column :media_items, :title
    remove_column :media_items, :thumbnail
    remove_column :media_items, :width
    remove_column :media_items, :height
    remove_column :media_items, :playing_square_id
  end
end
