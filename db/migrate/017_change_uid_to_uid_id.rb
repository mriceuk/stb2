class ChangeUidToUidId < ActiveRecord::Migration
  def self.up
    add_column :entrants, :uid_id, :integer
    remove_column :entrants, :uid
  end

  def self.down
    remove_column :entrants, :uid_id
    add_column :entrants, :uid, :integer
  end
end
