class AddIndexOnEmailAndCreatedAt < ActiveRecord::Migration
  def self.up
    add_index :entrants, [:email, :created_at]
  end

  def self.down
    remove_index :entrants, [:email, :created_at]      
 end
end
