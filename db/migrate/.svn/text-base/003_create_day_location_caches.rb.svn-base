class CreateDayLocationCaches < ActiveRecord::Migration
  def self.up
    create_table :day_position_caches do |t|
      t.string :positions
      t.datetime :created_at
      t.datetime :updated_at
      t.date :created_on
      t.date :updated_on
    end
  end

  def self.down
    drop_table :day_position_caches
  end
end
