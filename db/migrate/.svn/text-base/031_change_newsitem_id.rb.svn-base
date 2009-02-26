class ChangeNewsitemId < ActiveRecord::Migration
  def self.up
    rename_column :media_items, :newsitem_id, :news_item_id
  end

  def self.down
    rename_column :media_items, :news_item_id, :newsitem_id
  end
end
