class CreateDraws < ActiveRecord::Migration
  def self.up
    create_table :draws do |t|
        t.column :created_on, :datetime
        t.column :play_date, :datetime
        t.column :drawn, :boolean, :default=>false
        t.column :winner_id, :integer
        t.column :winning_zone, :integer
        t.column :draw_date, :date
    end
  end

  def self.down
    drop_table :draws
  end
end
