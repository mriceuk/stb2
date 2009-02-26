class CreateAuditData < ActiveRecord::Migration
  def self.up
    # game_start = Date.parse("2008-05-27")
    # game_end   = Date.parse("2008-06-20")
    
    # params for testing triggers
    game_start = Date.parse("2008-05-26")
    game_end   = Date.parse("2008-06-26")

    # a MySQL trigger will update the count in these rows when data is created
    (game_start..game_end).each do |date|
      (1..100).each do |square|
        execute("INSERT INTO bull_location_audits (date, square_number) VALUES('#{date}', #{square})");
        execute("INSERT INTO entrant_location_audits (date, square_number) VALUES('#{date}', #{square})");
      end
    end
  end

  def self.down
  end
end
