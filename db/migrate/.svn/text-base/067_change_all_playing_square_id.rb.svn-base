class ChangeAllPlayingSquareId < ActiveRecord::Migration
  def self.up
    change_column :entrants, :playing_square_id, :integer, :limit => 3
    change_column :bull_locations, :playing_square_id, :integer, :limit => 3
  end

  def self.down
    change_column :entrants, :playing_square_id, :integer
    change_column :bull_locations, :playing_square_id, :integer
  end
end
