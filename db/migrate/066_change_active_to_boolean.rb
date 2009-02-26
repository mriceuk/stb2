class ChangeActiveToBoolean < ActiveRecord::Migration
  def self.up
    change_column :entrants, :active, :boolean
  end

  def self.down
    change_column :entrants, :active, :boolean
  end
end
