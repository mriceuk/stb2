class CreatePlayingSquares < ActiveRecord::Migration
  def self.up
    create_table :playing_squares do |t|
      t.datetime :created_at
      t.datetime :updated_at
      t.date :created_on
      t.date :updated_on
    end
    
    [1..100].each do |index|
      PlayingSquare.create
    end
    
  end

  def self.down
    drop_table :playing_squares
  end
end
