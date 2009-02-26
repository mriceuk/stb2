module VO
  class Game < Object
    attr_accessor :timetogoinseconds
    attr_accessor :locations
    attr_accessor :playable
    attr_accessor :email
    attr_accessor :uid
    attr_accessor :todaysdatetime
    attr_accessor :winningsquare
    attr_accessor :open
    
    def initialize
      @timetogoinseconds = 0
      @locations = []
      @playable = false
      @email = ""
      @uid = ""
      @todaysdatetime = ""
      @winningsquare = ""
      @open = "false"
    end
    
    def to_hash
      
      return {"timetogoinseconds"=>@timetogoinseconds,
           "locations"=>@locations,
           "playeable"=>@playeable,
           "email"=>@email, 
           "uid"=>@uid,
           "todaysdatetime"=>@todaysdatetime,
           "winningsquare"=>@winningsquare,
           "open"=>@open}
          
      
      
    end
  end
end





