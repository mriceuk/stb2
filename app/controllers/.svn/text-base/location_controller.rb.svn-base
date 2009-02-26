class LocationController < ApplicationController
  include Geo
  
  # getAllLocations
  #
  # out: Locations as Array encoded as AMF
  
  def getAllLocations
    @locations  =  BullLocation.find(:all,:include=>"news_item")

       respond_to do |format|
         format.html # index.rhtml
         format.xml  { render :xml => @locations.to_xml }
         format.amf { render :amf => @locations }
       end
  end
  
  
  # getBullLocationsForDate
  #
  # in: playDate as String with format "YYYY-MM-DD"
  # out: Locations as Array encoded as AMF


  def getBullLocationsForDate
    
    playDate = params[:date]
    
    @locations  =  BullLocation.find(:all,:conditions=>["bull_locations.created_on = ?",playDate])

    respond_to do |format|
      format.html # index.rhtml
      format.xml  { render :xml => @locations.to_xml }
      format.amf { render :amf => @locations }
    end
  end




  def getLatestBullLocationsForToday

    _now = (Time.now).to_s:db
    _hour_ago = (Time.now - 3600).to_s:db
    
    @locations  =  BullLocation.find(:all,:conditions=>["created_at >= ? and created_at <= ?",_hour_ago,_now])

    respond_to do |format|
      format.html # index.rhtml
      format.xml  { render :xml => @locations.to_xml }
      format.amf { render :amf => @locations }
    end
  end


  # getBullLocationsForToday
  #
  # out: Locations as Array encoded as AMF


  def getBullLocationsForToday()

    @locations  =  BullLocation.find(:all,:conditions=>["bull_locations.created_on = ?",Date.today.to_s])

    respond_to do |format|
      format.html # index.rhtml
      format.xml  { render :xml => @locations.to_xml }
      format.amf { render :amf => @locations }
    end
  end
  
end
