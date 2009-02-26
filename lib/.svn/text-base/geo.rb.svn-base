require 'open-uri'
require 'rexml/document'
require 'cgi'
require 'csv'
require 'htmlentities'


module Geo
  include REXML

  WEATHER_URL = "http://feeds.bbc.co.uk/weather/feeds/rss/obs/id/2839.xml"

  def totalDistanceTravelled(_aPoints)
    
    totalDistance = 0
    
    _aPoints.each_index do |index|
      if index != 0
          totalDistance += distance(_aPoints[index], _aPoints[index-1])
      end
    end
    
    return totalDistance

  end
  
  
  def distance(p1,p2)
    return Math.sqrt(((p2.x - p1.x) * (p2.x - p1.x)) + ((p2.y - p1.y) * (p2.y - p1.y)))
  end

  
  def angleBetweenPoints(p1, p, p2)
            v1 = Point.new(0,0)
        	v2 = Point.new(0,0)
        	z = 0.0
        	s = 0.0
        	theta = 0.0
        	t1 = 0.0
        	t2 = 0.0

        	v1.setLocation(p1.x - p.x, p1.y - p.y)
        	v2.setLocation(p2.x - p.x, p2.y - p.y)

        	z = (v1.x * v2.y) - (v1.y * v2.x)
        	
        	s = (z >= 0.0) ? 1.0 : -1.0
        	
        	t1 = length(v1) * length(v2)
        	
        	if (t1 == 0.0)
        	    theta = 0.0
        	else
        	    t2 = ((v1.x * v2.x) + (v1.y * v2.y)) / t1
        	    if ((t2 < -1) || (t2 > 1))
        		    theta = 0.0
        	    else
        		    theta = (s * Math.acos(t2))
        	    end
        	end

        	return theta
  end
  
  
  def getWeatherDetails

     temperatureString = "" 
     humidityString = "" 
     pressureString = "" 
     visibilityString = "" 
     windDirectionString = "" 
     windSpeedString = "" 

     theHash = {}

     begin
       weather = REXML::Document.new(open(WEATHER_URL).read)
       details = XPath.first(weather, "//item")


      description=""

       XPath.each(details, "//description") do |desc|
         description = desc.text
       end


       detailsArray = description.split(",")

       temperatureString = detailsArray[0].split(":")[1].strip
       windDirectionString =  detailsArray[1].split(":")[1].strip
       windSpeedString =  detailsArray[2].split(":")[1].strip
       humidityString =  detailsArray[3].split(":")[1].strip 
       pressureString =  detailsArray[4].split(":")[1].strip
       visibilityString = detailsArray[6].split(":")[1].strip


       theHash["temperature"] = temperatureString.gsub(/\xC2\xb0/,"")
       theHash["windDirection"]  = windDirectionString
       theHash["windSpeed"]  = windSpeedString
       theHash["humidity"]  = humidityString
       theHash["pressure"]  = pressureString
       theHash["visibility"]  = visibilityString



     rescue


       temperatureString = "9C (48F)" 
       humidityString = "72%" 
       pressureString = "1023mB" 
       visibilityString = "Excellent" 
       windDirectionString = "SW" 
       windSpeedString = "8 mph" 


       theHash["temperature"] = temperatureString
       theHash["windDirection"]  = windDirectionString
       theHash["windSpeed"]  = windSpeedString
       theHash["humidity"]  = humidityString
       theHash["pressure"]  = pressureString
       theHash["visibility"]  = visibilityString


     end


     return theHash

   end
     
  
  module_function :angleBetweenPoints, :distance, :totalDistanceTravelled, :getWeatherDetails

end
