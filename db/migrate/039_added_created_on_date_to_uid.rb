class AddedCreatedOnDateToUid < ActiveRecord::Migration
  def self.up
     add_column :uids, :created_on, :date
  end

  def self.down
     remove_column :uids, :created_on
  end
end
