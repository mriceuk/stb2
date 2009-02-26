class FarmField < ActiveRecord::Base


  def FarmField.time_to_next_draw_in_seconds
      now = Time.now
      
      if now.hour >= 15
          drawCloses = Time.mktime(now.year, now.month, now.day, 15, 00, 0, 0)+86400
      else
          drawCloses = Time.mktime(now.year, now.month, now.day, 15, 00, 0, 0)
      end
      
      ((Time.parse(drawCloses.to_s)-Time.parse(now.to_s)).abs.round)
  end
    
end
