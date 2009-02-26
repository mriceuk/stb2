class ChangeDrawDateToDate < ActiveRecord::Migration
  def self.up
    change_column :draws, :play_date, :date
  end

  def self.down
    change_column :draws, :play_date, :datetime
  end
end
