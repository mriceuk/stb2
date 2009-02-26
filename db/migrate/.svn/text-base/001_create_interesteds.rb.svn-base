class CreateInteresteds < ActiveRecord::Migration
  def self.up
    create_table :interesteds do |t|
      t.string :email
      t.date :created_on

      t.timestamps
    end
  end

  def self.down
    drop_table :interesteds
  end
end
