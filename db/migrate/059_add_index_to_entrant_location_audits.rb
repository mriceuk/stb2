class AddIndexToEntrantLocationAudits < ActiveRecord::Migration
  def self.up
    add_index :entrant_location_audits, [:date, :square_number]
  end

  def self.down
    remove_index :entrant_location_audits, [:date, :square_number]
  end
end
