class DateAdded < ActiveRecord::Migration
  def self.up
    remove_column :entrants, :created_on
    add_column :entrants, :date_added, :string
  end

  def self.down
    remove_column :entrants, :date_added
    add_column :entrants, :created_on, :date
  end
end
