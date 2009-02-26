class AddDefaultValueToActive < ActiveRecord::Migration
  
  def self.up
    change_column :entrants, :active, :integer, :default => 0
  end

  def self.down
    
  end
  
end
