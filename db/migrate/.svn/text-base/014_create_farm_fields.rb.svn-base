class CreateFarmFields < ActiveRecord::Migration
  def self.up
    create_table :farm_fields do |t|
      t.timestamps
    end
    
    FarmField.create
  end

  def self.down
    drop_table :farm_fields
  end
end
