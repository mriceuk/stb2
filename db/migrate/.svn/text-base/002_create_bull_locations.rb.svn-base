class CreateBullLocations < ActiveRecord::Migration
  def self.up
    create_table :bull_locations do |t|
      t.integer :x
      t.integer :y
      t.integer :playing_square_id
      t.datetime :created_at
      t.datetime :updated_at
      t.date :created_on
      t.date :updated_on
 
    end
  end

  def self.down
    drop_table :bull_locations
  end
end
