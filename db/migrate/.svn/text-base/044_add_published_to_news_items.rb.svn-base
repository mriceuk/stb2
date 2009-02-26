class AddPublishedToNewsItems < ActiveRecord::Migration
  def self.up
    add_column :news_items, :published, :boolean, :default => false
  end

  def self.down
    remove_column :news_items, :published
  end  
end
