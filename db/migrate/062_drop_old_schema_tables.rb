class DropOldSchemaTables < ActiveRecord::Migration
  def self.up
    drop_table :interesteds
    drop_table :weather_caches
    drop_table :playing_squares
    drop_table :field_stats_caches
    drop_table :farm_fields
    drop_table :day_position_caches
  end

  def self.down
    create_table "day_position_caches", :force => true do |t|
      t.string   "positions"
      t.datetime "created_at"
      t.datetime "updated_at"
      t.date     "created_on"
      t.date     "updated_on"
    end
    
    create_table "farm_fields", :force => true do |t|
      t.datetime "created_at"
      t.datetime "updated_at"
    end
    
    create_table "field_stats_caches", :force => true do |t|
      t.integer  "avg_mph"
      t.string   "stat"
      t.datetime "created_at"
      t.datetime "updated_at"
      t.date     "created_on"
      t.date     "updated_on"
    end
    
    create_table "playing_squares", :force => true do |t|
      t.datetime "created_at"
      t.datetime "updated_at"
      t.date     "created_on"
      t.date     "updated_on"
    end
    
    create_table "weather_caches", :force => true do |t|
      t.string   "temperature"
      t.string   "precipitation"
      t.datetime "created_at"
      t.datetime "updated_at"
      t.date     "created_on"
      t.date     "updated_on"
    end
    
    create_table "interesteds", :force => true do |t|
      t.string   "email"
      t.date     "created_on"
      t.datetime "created_at"
      t.datetime "updated_at"
    end
    
  end
end
