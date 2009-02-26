class AddEntrantIdToUid < ActiveRecord::Migration
  def self.up
     add_column :uids, :entrant_id, :integer
  end

  def self.down
    remove_column :uids, :entrant_id
  end
end
