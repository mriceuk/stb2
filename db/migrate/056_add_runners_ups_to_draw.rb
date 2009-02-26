class AddRunnersUpsToDraw < ActiveRecord::Migration
  def self.up
    add_column :draws, :runner_up_1_id, :integer
    add_column :draws, :runner_up_2_id, :integer
  end

  def self.down
    remove_column :draws, :runner_up_1_id
    remove_column :draws, :runner_up_2_id
  end
end
