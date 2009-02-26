class AddIpAddressToEntrants < ActiveRecord::Migration
  def self.up
    add_column :entrants, :ip_address, :string
  end

  def self.down
    remove_column :entrants, :ip_address
  end
end
