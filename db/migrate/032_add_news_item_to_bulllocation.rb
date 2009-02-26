class AddNewsItemToBulllocation < ActiveRecord::Migration
  def self.up
    add_column :bull_locations, :news_item_id, :integer
  end

  def self.down
    remove_column :bull_locations, :news_item_id
  end
end
