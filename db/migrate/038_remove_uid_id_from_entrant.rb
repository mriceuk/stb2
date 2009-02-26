class RemoveUidIdFromEntrant < ActiveRecord::Migration
  def self.up
    remove_column :entrants, :uid_id
  end

  def self.down
    add_column :entrants, :uid_id, :integer
  end
end
