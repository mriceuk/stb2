class AddBullLocationTrigger < ActiveRecord::Migration
  def self.up
    execute(
    "CREATE TRIGGER bl_audit AFTER INSERT ON bull_locations FOR EACH ROW 
     UPDATE bull_location_audits SET count = count + 1 WHERE date = NEW.created_on AND square_number = NEW.playing_square_id;")
  end

  def self.down
    execute("DROP TRIGGER bl_audit;")
  end
end
