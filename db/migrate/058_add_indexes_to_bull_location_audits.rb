class AddIndexesToBullLocationAudits < ActiveRecord::Migration
  def self.up
    add_index :bull_location_audits, [:date, :square_number]
  end

  def self.down
    remove_index :bull_location_audits, [:date, :square_number]
  end
end
