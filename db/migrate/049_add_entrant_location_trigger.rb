class AddEntrantLocationTrigger < ActiveRecord::Migration
  def self.up
    execute(
    "CREATE TRIGGER el_audit AFTER INSERT ON entrants FOR EACH ROW
     UPDATE entrant_location_audits SET count = count + 1 WHERE date = NEW.created_on AND square_number = NEW.playing_square_id;")
  end

  def self.down
    execute("DROP TRIGGER el_audit;")
  end
end
