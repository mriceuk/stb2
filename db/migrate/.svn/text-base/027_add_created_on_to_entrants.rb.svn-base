class AddCreatedOnToEntrants < ActiveRecord::Migration
  def self.up
    change_column :entrants, :date_added, :date
    rename_column :entrants, :date_added, :created_on
  end

  def self.down
    change_column :entrants, :created_on, :string
    rename_column :entrants, :created_on, :date_added
  end
end
