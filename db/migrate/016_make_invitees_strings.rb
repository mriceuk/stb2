class MakeInviteesStrings < ActiveRecord::Migration
  def self.up
    change_column :groups, :invitee_1, :string
    change_column :groups, :invitee_2, :string
    change_column :groups, :invitee_3, :string
    change_column :groups, :invitee_4, :string
  end

  def self.down
    change_column :groups, :invitee_1, :string
    change_column :groups, :invitee_2, :string
    change_column :groups, :invitee_3, :string
    change_column :groups, :invitee_4, :string
  end
end
