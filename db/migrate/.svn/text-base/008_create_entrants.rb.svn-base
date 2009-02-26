class CreateEntrants < ActiveRecord::Migration
  def self.up
    create_table :entrants do |t|
      t.string :name
      t.string :email
      t.integer :group_id
      t.integer :uid
      t.integer :playing_square_id
      t.boolean :active
      t.boolean :winner
      t.datetime :created_at
      t.datetime :updated_at
      t.date :created_on
      t.date :updated_on
    end
  end

  def self.down
    drop_table :entrants
  end
end
