class CreateWeatherCaches < ActiveRecord::Migration
  def self.up
    create_table :weather_caches do |t|
      t.string :temperature
      t.string :precipitation
      t.datetime :created_at
      t.datetime :updated_at
      t.date :created_on
      t.date :updated_on
    end
  end

  def self.down
    drop_table :weather_caches
  end
end
