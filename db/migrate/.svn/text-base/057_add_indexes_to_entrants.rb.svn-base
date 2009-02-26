class AddIndexesToEntrants < ActiveRecord::Migration
  def self.up
    add_index :entrants, :draw_id
    add_index :entrants, :created_at
  end

  def self.down
    remove_index :entrants, :created_at
    remove_index :entrants, :draw_id
  end
end
