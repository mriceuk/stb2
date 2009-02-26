class AddIndexesToEntrants < ActiveRecord::Migration
  def self.up
    add_index :entrants, :date_added
    add_index :entrants, [:date_added, :playing_square_id]
  end

  def self.down
    remove_index :entrants, :date_added
    remove_index :entrants, [:date_added, :playing_square_id]
  end
end
