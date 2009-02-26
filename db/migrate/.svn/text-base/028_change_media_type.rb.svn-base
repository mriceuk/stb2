class ChangeMediaType < ActiveRecord::Migration
  def self.up
    add_column :media_items, :content_type, :string
    add_column :media_items, :filename, :string
    add_column :media_items, :size, :integer

  end

  def self.down
    remove_column :media_items, :content_type
    remove_column :media_items, :filename
    remove_column :media_items, :size

  end
end
