class Entrant < ActiveRecord::Base

  has_one :uid
  has_one :group
  belongs_to :group
  belongs_to :draw
  
  validates_presence_of :email
  
  attr_accessor :counter
  attr_accessor :terms

  def before_create
    
    self.uid = Uid.create

  end
  
  def after_create
    
    #when originator
    if self.group_id.blank?
      g = Group.new(:originator_id => self.id)
      g.save!
      self.group_id = g.id
      self.save!
    end
    
  end
  
  def validate_on_update
  
    if Time.now.hour == 14 
      errors.add_to_base("The game is closed between 2pm and 3pm<br>")
    end

    if self.created_at.hour >= 15
      startofdraw = Time.mktime(created_at.year, created_at.month, created_at.day, 15, 00, 0, 0)
      endofdraw = Time.mktime(created_at.year, created_at.month, created_at.day, 14, 00, 0, 0) + 86400
    else
      startofdraw = Time.mktime(created_at.year, created_at.month, created_at.day, 15, 00, 0, 0) - 86400
      endofdraw = Time.mktime(created_at.year, created_at.month, created_at.day, 14, 00, 0, 0)
    end
  
    end_of_draw = Time.now.yesterday

    #if update attempt occurs after end of draw
    if (Time.now > endofdraw)
      errors.add_to_base("You can not complete your entry at this time as the deadline for the draw you were entered into has passed<br>")
    end

  end

  def validForTodaysDraw?
    now =Time.now
   
    if now.hour >= 15

      startofdraw = Time.mktime(now.year, now.month, now.day, 15, 00, 0, 0) 
      endofdraw = Time.mktime(now.year, now.month, now.day, 14, 00, 0, 0) + 86400
    else

      startofdraw = Time.mktime(now.year, now.month, now.day, 15, 00, 0, 0) - 86400
      endofdraw = Time.mktime(now.year, now.month, now.day, 14, 00, 0, 0)
    end
    
    if self.created_at > startofdraw && self.created_at < endofdraw
      return true
    else
      return false
    end

  end
  
  def hasnt_played_today?
  
    now = Time.now

    if now.hour >= 15

      startofdraw = Time.mktime(now.year, now.month, now.day, 15, 00, 0, 0) 
      endofdraw = Time.mktime(now.year, now.month, now.day, 14, 00, 0, 0) + 86400
    else

      startofdraw = Time.mktime(now.year, now.month, now.day, 15, 00, 0, 0) - 86400
      endofdraw = Time.mktime(now.year, now.month, now.day, 14, 00, 0, 0)
    end

    if self.created_at > startofdraw && self.created_at < endofdraw
      return false
    else
      return true 
    end

       
  end
  

  def validate_on_create
    
    #dont allow entrants to be created between 2 and 3
    if Time.now.hour == 14 
      errors.add_to_base("The game is closed between 2pm and 3pm<br>")
    end

    now = Time.now
    
    if now.hour > 14
         startofdraw = Time.mktime(now.year, now.month, now.day, 15, 00, 0, 0)
         endofdraw = Time.mktime(now.year, now.month, now.day, 14, 00, 0, 0) + 86400
    else
         startofdraw = Time.mktime(now.year, now.month, now.day, 15, 00, 0, 0) - 86400
         endofdraw = Time.mktime(now.year, now.month, now.day, 14, 00, 0, 0)
    end

    todaysStart = startofdraw.to_s:db
    todaysEnd = endofdraw.to_s:db

    @entry = Entrant.find(:first, :conditions => ["email = ? and created_at >= ? and created_at < ?", self.email, todaysStart, todaysEnd])
    #debugger
    
    if @entry
      zone_text = @entry.playing_square_id ? " (you picked zone: #{@entry.playing_square_id})" : '' 
      errors.add_to_base("Email address #{@entry.email} has already been entered for today's draw#{zone_text}<br>")
    end
    
    if self.playing_square_id
      unless (self.playing_square_id.to_i > 0 and self.playing_square_id.to_i < 101) 
        errors.add_to_base("Please select a square with a valid number from 1 to 100") 
      end
    end

  end

  def Entrant.find_by_uid(uid)
  
    uid = Uid.find_by_uid(uid)
    
    if uid
      return uid.entrant(:include=>"uid")
    else
      nil
    end
    
  end
  
  
  
end