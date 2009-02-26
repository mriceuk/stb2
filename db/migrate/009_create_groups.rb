class CreateGroups < ActiveRecord::Migration
  def self.up
    create_table :groups do |t|
      t.integer :originator_id
      t.integer :invitee_1
      t.integer :invitee_2
      t.integer :invitee_3
      t.integer :invitee_4
      t.boolean :active
      t.date :created_on
      t.timestamps
    end
  end

  def self.down
    drop_table :groups
  end
end
