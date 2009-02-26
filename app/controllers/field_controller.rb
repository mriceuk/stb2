require 'open-uri'
require 'rexml/document'


class FieldController < ApplicationController
  include Geo
  include REXML

  #  @weather_url = "http://feeds.bbc.co.uk/weather/feeds/rss/obs/id/2839.xml"
  WEATHER_URL = "http://feeds.bbc.co.uk/weather/feeds/rss/obs/id/2861.xml"

  # getWeatherDetails
  #
  # out: Seconds to go as Number encoded as AMF
  
  def getWeatherDetails
      respond_to do |format|
        format.amf { render :amf => Geo.getWeatherDetails()}
      end
  end
  
      
  # getCountdownDetails
  #
  # out: Seconds to go as Number encoded as AMF
  
  def getCountdownDetails
      respond_to do |format|
        format.amf { render :amf => FarmField.time_to_next_draw_in_seconds}
      end
  end
  
  # getPlayingActivityMap
  #
  # used to display heatmap for player activity
  # in: startDate as String with format "YYYY-MM-DD"
  # in: endDate as String with format "YYYY-MM-DD"
  
  def getPlayingActivityMap
    

     period = params[:period]

    case 
       when period == "today" then
         startDate = endDate = Date.today.to_s
       when period == "yesterday" then
         startDate = endDate = (Date.today-1).to_s
       when period == "pastweek" then
         startDate = (Date.today-7).to_s
         endDate = Date.today.to_s
       when period == "ever" then
         startDate = STARTDATE
         endDate = Date.today.to_s
       else  
         startDate = endDate = Date.today.to_s
     end

        
    @activity = Hash.new(0)
    
    (startDate..endDate).each do |date|
      (1..100).each do |square|
        @activity["#{square}"] += EntrantLocationAudit.find(:first, :conditions => "date = '#{date}' AND square_number = '#{square}'").count 
      end
    end
  
  
    # find highest activity key value
  #  @highest = @activity.values.max
    
   # case 
   # when @highest == 0 then @factor = 1  
   # when @highest > 100 then @factor = @highest.to_f / 100.0
   # when @highest <= 100 then @factor = 100.0 / @highest.to_f 
  #  end
        
   # unless @activity.empty?
   #   (1..100).each do |square|
   #     @activity["#{square}"] = (@activity["#{square}"].to_f * @factor).to_i
   #   end
   # end
    
    respond_to do |format|
      format.html # index.rhtml
      format.xml  { render :xml => @activity.to_xml }
      format.amf { render :amf =>  @activity }
    end
    
    # puts "Highest: " + @highest.to_s
    # puts "Factor: " + @factor.to_s
    # puts @activity.inspect
    
  end
 
  
  # getBullActivityMap
  #
  # used to display heatmap for bull location activity
  # in: startDate as String with format "YYYY-MM-DD"
  # in: endDate as String with format "YYYY-MM-DD"
  def getBullActivityMap

    period = params[:period]

   case 
      when period == "today" then
        startDate = endDate = Date.today.to_s
      when period == "yesterday" then
        startDate = endDate = (Date.today-1).to_s
      when period == "pastweek" then
        startDate = (Date.today-7).to_s
        endDate = Date.today.to_s
      when period == "ever" then
        startDate = STARTDATE
        endDate = Date.today.to_s
      else  
        startDate = endDate = Date.today.to_s
    end
  

    @activity = Hash.new(0)

    (startDate..endDate).each do |date|
      (1..100).each do |square|
        @activity["#{square}"] += BullLocationAudit.find(:first, :conditions => "date = '#{date}' AND square_number = '#{square}'").count 
      end
    end

    # find highest activity key value
   # @highest = @activity.values.max

   # case 
   # when @highest == 0 then @factor = 1  
   # when @highest > 100 then @factor = @highest.to_f / 100.0
   # when @highest <= 100 then @factor = 100.0 / @highest.to_f 
   # end

   # unless @activity.empty?
   #   (1..100).each do |square|
   #     @activity["#{square}"] = (@activity["#{square}"].to_f * @factor).to_i
   #   end
   # end

    respond_to do |format|
      format.html # index.rhtml
      format.xml  { render :xml => @activity.to_xml }
      format.amf { render :amf =>  @activity }
    end

    # puts "Highest: " + @highest.to_s
    # puts "Factor: " + @factor.to_s
    # puts @activity.inspect
  end


  # getPlayingActivityMapForDate
  #
  # used to display heatmap 
  # in: playDate as String with format "YYYY-MM-DD"


  def getPlayingActivityMapForDate(playDate = Date.today.to_s)

   # playDate = params[:date]

    @entrants  = Entrant.find_by_sql("select playing_square_id,count(*) as counter from entrants where created_on = '#{playDate}' group by playing_square_id order by count(*) DESC;")
    
    @filtered = {}

    (1..100).each do |index|
      @filtered["#{index}"] = 0
    end
    
    @highest  = @entrants[0]["counter"].to_f  
    
    if @highest > 100
      @factor  = @entrants[0]["counter"].to_f / 100.0  
    else
      @factor  = 100.0 / @entrants[0]["counter"].to_f 
    end
    
    
    if not @entrants.empty?
      
      @entrants.each do |entrant|
        @filtered["#{entrant['playing_square_id']}"] = (entrant['counter'].to_f * @factor).to_i
      end
      
      respond_to do |format|
         format.html # index.rhtml
         format.xml  { render :xml => @filtered.to_xml }
         format.amf { render :amf =>  @filtered }
       end
      
      # puts @filtered.inspect
    
    end
  end




  # getBullActivityMapForDate
  #
  # used to display heatmap 
  # in: playDate as String with format "YYYY-MM-DD"
  

  def getBullActivityMapForDate

    #playDate = params[:date]

    @bull_locations  = BullLocation.find_by_sql("select playing_square_id,count(*) as counter from bull_locations where created_on = '#{playDate}' group by playing_square_id order by count(*) DESC;")
    
    @filtered = {}

    (1..100).each do |index|
      @filtered["#{index}"] = 0
    end
    
    @highest  = @bull_locations[0]["counter"].to_f  
    
    if @highest > 100
      @factor  = @bull_locations[0]["counter"].to_f / 100.0  
    else
      @factor  = 100.0 / @bull_locations[0]["counter"].to_f 
    end
    
    
    if not @bull_locations.empty?
      
      @bull_locations.each do |location|
        @filtered["#{location['playing_square_id']}"] = (location['counter'].to_f * @factor).to_i
      end
      
      respond_to do |format|
        format.html # index.rhtml
        format.xml  { render :xml => @filtered.to_xml }
        format.amf { render :amf =>  @filtered }
      end
    
    end
  end



  def getNews
    
    @newitems  =  NewsItem.find(:all,:order=>"created_at DESC")

    respond_to do |format|
      format.html # index.rhtml
      format.xml  { render :xml => @locations.to_xml }
      format.amf { render :amf => @locations }
    end
  end
  

  # getAllSquares
  #
  # used 
  # in: playDate as String with format "DD-MM-YYYY"
  # out: Seconds to go as Number encoded as AMF
  
 
  def getAllSquares
    @locations  =  BullLocation.find(:all, :order=>"created_at DESC", :limit=>20)

       respond_to do |format|
         format.html # index.rhtml
         format.xml  { render :xml => @locations.to_xml }
         format.amf { render :amf => @locations }
       end
  end
  

  def getGameDetailsWithDateAndEmailAndUid

    date = params[:datetime].to_s
    email = params[:email].to_s
    uid = params[:uid].to_s

     details = Hash.new
      error = nil
      details["datetimenow"] = Time.now.to_s
      details["winningsquare"] = Draw.latestWinningSquare.to_s
      details["gamemode"] = Draw.isOpen?
      details["timetogoinseconds"] = FarmField.time_to_next_draw_in_seconds
      details["usermode"] = "player"



      if uid != ""
          theUID = Uid.find_by_uid(uid)

          if theUID
             entrant = theUID.entrant(:include=>"group")

             if entrant.hasnt_played_today?               
               if not entrant.validForTodaysDraw?
                 error =  "initial expired"
                end               
             else  
                details["usermode"] = "observer"
                details["square"] = theUID.entrant.playing_square_id.to_s
                error = "already entered"
             end
              
             
             if error == nil || error =="already entered"
               details["entrant_uid"] = entrant.uid.uid
               group = entrant.group
               details["originator_square"] = Entrant.find(group.originator_id).playing_square_id

               count = 1
               group.entrants.each_with_index do |entrant,index|
                 if entrant.playing_square_id != details["originator_square"] && entrant.playing_square_id!=nil
                   details["invitee_square_"+count.to_s] = entrant.playing_square_id
                   count = count + 1 
                 end
               end
               details["group_size"] = count
               details["square"] = theUID.entrant.playing_square_id.to_s
             end
        else
          details["usermode"] = "observer"
          error = "invalid entry"
        end
      else
        details["usermode"] = "observer"
        error = "invalid entry"
      end

      details["__message"] = error
      
  
            

      respond_to do |format|
           format.xml  { render :xml => details.to_xml }
           format.amf { render :amf => details     }
      end
      
  end
  
  
  
  
  # getGameDetailsWithInvitation
  #
  # When a person has been invited to play by a friend
  
  def getGameDetailsWithInvitation

    uid = params[:invitation].to_s
    
    details = Hash.new
    error = nil
    details["todaysdate"] = Date.today.to_s
    details["winningsquare"] =Draw.latestWinningSquare.to_s
    details["gamemode"] = Draw.isOpen?
    details["timetogoinseconds"] = FarmField.time_to_next_draw_in_seconds
    details["usermode"] = "player"
    
    if uid 
      theUID = Uid.find_by_uid(uid)
      
      if theUID
        entrant = theUID.entrant(:include=>"group")
        
        details["uid"] = entrant.uid.uid
        details["email"] = entrant.email

        group = entrant.group
  
        if not entrant.active?
          
          details["originator_square"] = Entrant.find(group.originator_id).playing_square_id
          details["originator_name"] = Entrant.find(group.originator_id).name

          if not entrant.validForTodaysDraw?
            error =  "invite expired"
          end
            
        else
          error =  "already accepted"
          details["square"] = theUID.entrant.playing_square_id.to_s
          
          details["usermode"] = "observer"
        end
        
        if error == nil
          details["entrant_uid"] = entrant.uid.uid
       
          count = 1
          group.entrants.each_with_index do |entrant,index|
            if entrant.playing_square_id != details["originator_square"]  && entrant.playing_square_id!=nil
                details["invitee_square_"+count.to_s] = entrant.playing_square_id
                count = count + 1 
              end
          end
         
          details["group_size"] = count
        end
        
        
        
      else
        error = "invalid entry"
        details["usermode"] = "observer"
      end
    else
      error = "invalid entry"
      details["usermode"] = "observer"
    end

    details["__message"] = error

    respond_to do |format|
         format.xml  { render :xml => details.to_xml }
         format.amf { render :amf => details     }
    end
  end




  def getGameDetails
    details = Hash.new
    details["todaysdate"] = Date.today.to_s
    details["winningsquare"] = Draw.latestWinningSquare.to_s
    details["gamemode"] = Draw.isOpen?
    details["timetogoinseconds"] = FarmField.time_to_next_draw_in_seconds
    
    if Draw.isOpen?
      details["usermode"] = "player"
    else
      details["usermode"] = "observer"
    end

    respond_to do |format|
         format.xml  { render :xml => details.to_xml }
         format.amf { render :amf => details     }
    end
end


  # ParameterMappings.register( {:controller => :FieldController, :action => :createEntrant, :params => {:uid => "[0]",:name=>"[1]",:email=>"[2]" :mobile=>"[3]", :square=>"[4]", :optin=>"[5]", :feed=>"[6]"}})
  #
  
	def createEntrant
	    
	    
	    _name=params[:name]
	    _email=params[:email]
	    _mobile=params[:mobile]
	    _optin=params[:optin]
	    _feed=params[:feed]
	    _square=params[:square].to_i
	    

	    
	    details = Hash.new
      details["saved"] = false.to_s
	     	    

     		entry = Entrant.new(:name=>_name,:email=>_email,:mobile=>_mobile,:optin=>_optin,:feed=>_feed,:playing_square_id=>_square,:active=>1)
  

             if entry.save
              details["saved"] = true.to_s
              details["uid"] = entry.uid.uid.to_s
              details["square"] = _square.to_s
              details["email"] = _email
              details["__name"] = _name
              details["datetime"] = Time.now.to_s:db
              details["__message"] = "Your entry (square:#{_square}) has been saved."
              details["usermode"] = "observer"
             
                
 
            else
              entry = Entrant.find(entry.errors.on(:id))   
          
              details["saved"] = false.to_s
              details["uid"] = entry.uid.uid.to_s
              details["square"] = entry.playing_square_id.to_s
              details["email"] = entry.email.to_s
              details["datetime"] = entry.created_at.to_s:db
              details["__name"] = entry.name
              details["__message"] = "already played"
    
            end
            
        
 
      respond_to do |format|
          format.html # index.rhtml
          format.xml  { render :xml => details.to_xml }
           format.amf { render :amf => details }
      end
 	end
 	
 	
 	def confirmSingleEntrant
  
    _uid=params[:uid]
    
    uid = Uid.find_by_uid(_uid)
    
    if(uid)
        entry = uid.entrant
        BullMailer.deliver_confirm(entry)   
      end
    
  end
  
  # ParameterMappings.register( {:controller => :FieldController, :action => :acceptInvitationAndUpdateEntrant, :params => {:uid => "[0]", :mobile=>"[1]", :square=>"[2]", :optin=>"[3]", :feed=>"[4]"}})
  #
  
 	def acceptInvitationAndUpdateEntrant
	    
	      _uid = params[:uid]
	      _name = params[:name]
	      _mobile = params[:mobile]
	      _optin = params[:optin]
	      _feed = params[:feed]
	      _square = params[:square]
	    
	      _uid = Uid.find_by_uid(_uid)
	    
	      errors = Array.new
        details = Hash.new
        details["saved"] = false
	     	    
	      if _uid
	        
	        entrant = _uid.entrant

       		if entrant
            entrant.uid = _uid
     		    entrant.update_attributes({:mobile=>_mobile,:name=>_name,:optin=>_optin,:feed=>_feed,:playing_square_id=>_square,:active=>true})
     		    
            details["saved"] = true.to_s
            details["uid"] = _uid.uid.to_s
            details["square"] = _square.to_s
            details["email"] = entrant.email
            details["datetime"] = Time.now.to_s:db
            details["__message"] = "Your entry (square:#{_square}) has been saved."
            details["usermode"] = "observer"
            details["__name"] =entrant.name
            
            # Send originator an email
            
            group = entrant.group
            originator = Entrant.find(group.originator_id)
            
            group.entrants.each do |entrano|
            
              if entrano.id != group.originator_id && entrano.id!= entrant.id 
                BullMailer.deliver_team_confirm(entrano,entrant)
              end
            end
            
            BullMailer.deliver_teammember_confirm(entrant)
            BullMailer.deliver_team_confirm(originator,entrant)

     		  else
   		      error= "bad uid"
            details["__message"] = error
     		    end
   		    
	      else
 		      error = "Couldn't find the Uid"
	          details["__message"] = error
        end  
	
	         
      respond_to do |format|
          format.html # index.rhtml
          format.xml  { render :xml => details.to_xml }
           format.amf { render :amf => details }
      end
 	end
 	
 	
 	def inviteFriends
	    
	    _uid  = params[:uid]
	    _friends  = params[:friends]
	    
	    
	    details = Hash.new
	    errors = Hash.new
	    friends = Array.new
	    uid = Uid.find_by_uid(_uid)
	    entrant = uid.entrant 
	    group = entrant.group
	
	    
	    _friends.each_with_index do |_friend,index|
	      friend = Entrant.new(:email=>_friend["email"],:active=>0)

        friend.group = group
  
	      if friend.valid?
	        if friend.save
	           group["invitee_"+(index+1).to_s] = friend.id
	           friends << friend
	        end
	       end
	      
      end

      group.save

      BullMailer.deliver_initiator(entrant)

      friends.each do |friend|
        
        BullMailer.deliver_invite(friend,entrant)
      end
      
      details["saved"] = true.to_s
      details["uid"] = _uid.to_s
      details["datetime"] = Time.now.to_s:db
      details["__message"] = "Your friends have been invited"
      details["usermode"] = "observer"
      details["__name"] =entrant.name
   
            
      
      respond_to do |format|
        format.html # index.rhtml
        format.xml  { render :xml => details.to_xml }
        format.amf { render :amf => details }
      end
 	end
 	
 	
 	
 	def createLocation
	    
	    x = params[:x]
	    y = params[:y]
	    square = params[:square]
	    details = Hash.new

	    last_location = BullLocation.find(:first, :order=>"created_at DESC")
	    
	    if(last_location != nil)
	      if(last_location.x == x.to_i && last_location.y == y.to_i)
	          details["saved"] = true.to_s
        end
      end
      
      if details["saved"]!=true.to_s 

  	    location = BullLocation.new(:x=>x,:y=>y,:playing_square_id=>square)

        details["saved"] = false.to_s

  	    if location.save
              details["saved"] = true.to_s
          else
              details["error"] = "Unable to save location."
          end

      end

        
        respond_to do |format|
           format.html # index.rhtml
           format.xml  { render :xml => details.to_xml }
           format.amf { render :amf => details }
         end
 	end
  
  
 
 
  
end
