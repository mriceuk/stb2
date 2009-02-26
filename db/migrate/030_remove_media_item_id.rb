class RemoveMediaItemId < ActiveRecord::Migration
  def self.up
  #  remove_column :news_items, :mediaitem_id
  end

  def self.down
    add_column :news_items, :mediaitem_id, :integer
  end
end
