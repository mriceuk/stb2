class ClearTablesAndRepopulate < ActiveRecord::Migration

  def self.up
  
    tables = ["bull_locations", "bull_location_audits", "draws", "emails", "entrant_location_audits", "entrants", "groups", "media_items", "news_items", "sessions", "uids", "users"]
    
    #delete all table data
    tables.each do |table_name|
     execute("TRUNCATE #{table_name}")
    end
    
    #add in audits
    game_start = Date.parse("2008-05-26")
    game_end   = Date.parse("2008-06-26")

    # a MySQL trigger will update the count in these rows when data is created
    (game_start..game_end).each do |date|
      (1..100).each do |square|
        execute("INSERT INTO bull_location_audits (date, square_number) VALUES('#{date}', #{square})");
        execute("INSERT INTO entrant_location_audits (date, square_number) VALUES('#{date}', #{square})");
      end
    end
    
    #add in users
    u = User.create!(:login => "admin", :password => "poke34", :email => "knotty@pokelondon.com", :password_confirmation => "poke34" )
    u2 = User.create!(:login => "locations", :password => "l0c5", :email => "locations@pokelondon.com", :password_confirmation => "l0c5")
  
  end

  def self.down
  
  end

end
