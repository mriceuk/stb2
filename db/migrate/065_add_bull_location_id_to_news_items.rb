class AddBullLocationIdToNewsItems < ActiveRecord::Migration
  def self.up
    add_column :news_items, :bull_location_id, :integer
  end

  def self.down
    remove_column :news_items, :bull_location_id
  end
end
