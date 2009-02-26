class CreateMediaItems < ActiveRecord::Migration
  def self.up
    create_table :media_items do |t|
      t.string :media_type
      t.string :uri
      t.integer :newsitem_id
      t.date :created_on
      t.timestamps
    end
  end

  def self.down
    drop_table :media_items
  end
end
