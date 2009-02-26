class AddIndexesToBullLocations < ActiveRecord::Migration
  def self.up
    add_index :bull_locations, :created_on
    add_index :bull_locations, :created_at
  end

  def self.down
    remove_index :bull_locations, :created_at
    remove_index :bull_locations, :created_on
  end
end
