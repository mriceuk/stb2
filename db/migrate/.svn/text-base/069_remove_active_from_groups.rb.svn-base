class RemoveActiveFromGroups < ActiveRecord::Migration
  def self.up
    remove_column :groups, :active
  end

  def self.down
    add_column :groups, :active, :boolean
  end
end
