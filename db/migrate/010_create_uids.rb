class CreateUids < ActiveRecord::Migration
  def self.up
    create_table :uids do |t|
      t.integer :uid
      t.timestamps
    end
  end

  def self.down
    drop_table :uids
  end
end
