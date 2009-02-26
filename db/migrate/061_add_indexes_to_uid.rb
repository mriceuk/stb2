class AddIndexesToUid < ActiveRecord::Migration
  def self.up
    add_index :uids, :uid
  end

  def self.down
    remove_index :uids, :uid
  end
end
