class CreateBullLocationAuditTable < ActiveRecord::Migration
  def self.up
    create_table :bull_location_audits do |t|
      t.column :date, :date
      t.column :square_number, :integer
      t.column :count, :integer, :default => 0
    end
  end

  def self.down
    drop_table :bull_location_audits
  end
end
