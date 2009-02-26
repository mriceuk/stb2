class DropFriendsTable < ActiveRecord::Migration
  def self.up
    drop_table :friends
  end

  def self.down
    create_table :friends do |t|
      t.column :created_at, :datetime
      t.column :updated_at, :datetime
    end
  end
end
