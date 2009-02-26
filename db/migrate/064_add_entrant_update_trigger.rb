class AddEntrantUpdateTrigger < ActiveRecord::Migration
  def self.up
    execute(
     "CREATE TRIGGER el_audit_update AFTER UPDATE ON entrants
      FOR EACH ROW
        BEGIN
          IF OLD.playing_square_id IS NULL
          THEN
            UPDATE entrant_location_audits SET count = count + 1 WHERE date = NEW.created_on AND square_number = NEW.playing_square_id;
          END IF;
        END")
  end

  def self.down
    execute("DROP TRIGGER el_audit_update;")
  end
end
