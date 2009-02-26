class AddOptinToEntrant < ActiveRecord::Migration
  def self.up
         add_column :entrants, :optin, :integer
  end

  def self.down
         remove_column :entrants, :optin
  end
end
