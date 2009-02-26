class RemovePlayingSquareIdLinkNewsToBullLocation < ActiveRecord::Migration
  def self.up
    remove_column :media_items, :playing_square_id
    add_column :news_items, :bull_location_id, :integer
  end

  def self.down
#    add_column :media_items, :playing_square_id, :integer
 #  remove_column :news_items, :bull_location_id

  end
end
