class RemoveWinner < ActiveRecord::Migration
  def self.up
    remove_column :entrants, :winner
  end

  def self.down
    add_column :entrants, :winner, :integer
  end
end
