class ChangeDrawWinningZoneToWinningSquare < ActiveRecord::Migration
  def self.up
    rename_column :draws, :winning_zone, :winning_square
  end

  def self.down
    rename_column :draws, :winning_square, :winning_zone
  end
end
