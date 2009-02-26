class CreateEmails < ActiveRecord::Migration
  def self.up
    create_table :emails do |t|
      t.integer :entry_id
      t.string :receiver_email
      t.date :created_on
      t.timestamps
    end
  end

  def self.down
    drop_table :emails
  end
end
