class AddCreatedAtIndexToNewItems < ActiveRecord::Migration
  def self.up
     add_index :news_items, :created_at
  end

  def self.down
     remove_index :entrants, :created_at
  end
end
