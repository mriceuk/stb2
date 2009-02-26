class RemoveInviteesFromGroups < ActiveRecord::Migration
  def self.up
    remove_column :groups, :invitee_1
    remove_column :groups, :invitee_2
    remove_column :groups, :invitee_3
    remove_column :groups, :invitee_4
  end

  def self.down
    add_column :groups, :invitee_1, :string  
    add_column :groups, :invitee_2, :string
    add_column :groups, :invitee_3, :string
    add_column :groups, :invitee_4, :string
  end
end
