class Draw < ActiveRecord::Base
  require 'csv'
  
  #attr_reader :winning_square

  has_many :entrants

  def generate(date = Date.today)
  
    delete_previous_draw
    
    unless winning_square_for(date) then return false end
    
    play_date = date
    qualifiers(date)
    
    if qualifiers.size > 0
    
      winners(date)
      entrants_list(date)
      drawn = true
      save
    
    else
      return false
    end
  
  end
  
  def before_create
    self.play_date = Date.today
  end
  
  # deadline string for date
  def deadline(date = Date.today)
   # if Time.now.hour < 15
   #   date = date.yesterday
   # end
    date.to_s + " 15:00:00"
  end
  
  def delete_previous_draw
    Draw.delete_all("play_date = '#{Date.today.to_s(:db)}'")
  end
  
  def Draw.latestWinningSquare

      winner = Draw.find(:first, :order=>"created_on desc")
      
      if winner 
        winner.winning_square
      else
        winner = 1
      end
  end
  
  # returns winning square from draw on date
  def winning_square_for(date = Date.today)
    square =  BullLocation.find(:first, :conditions => " #{playing_square_valid_between(date = date)} ", :order => ' id DESC')
    if square
      self.winning_square = square.playing_square_id
    else 
      return false
    end
  end
  
  def playing_square_valid_between(date = Date.today)
    entry_valid_after  = date.yesterday.to_s + " 15:00:00"
    entry_valid_before = date.to_s + " 15:00:00"
    entry_valid_between = "created_at >= '#{entry_valid_after}' AND created_at < '#{entry_valid_before}'"
  end
  
  def entry_valid_between(date = Date.today)
    entry_valid_after  = date.yesterday.to_s + " 15:00:00"
    entry_valid_before = date.to_s + " 14:00:00"
    entry_valid_between = "created_at >= '#{entry_valid_after}' AND created_at < '#{entry_valid_before}'"
  end
  
  def entrants_for(date = Date.today)    
    entrants = Entrant.find(:all, :conditions => "#{entry_valid_between} and active = 1")
  end
    
  def qualifiers(date = Date.today)    
    self.save
    draw_id = self.id

    #IF(active = 1,'qualifier','loser')
    Entrant.update_all("draw_id = #{draw_id}, entry_result = IF(playing_square_id = #{winning_square_for(date)} , 'qualifier', 'loser')  ", entry_valid_between + " and active = 1")

    qualifiers = Entrant.find(:all, :conditions => "entry_result = 'qualifier' and  #{entry_valid_between} and active = '1'") 
    
    #make all group members qualifiers
    qualifiers.each do |q|
      Entrant.update_all("entry_result = 'qualifier'","group_id = #{q.group_id} and #{entry_valid_between} and active = '1' ")
    end

    return qualifiers
    
  end
  
  def qualifiers_list
    
   Entrant.find(:all, :conditions => entry_valid_between + " and active = '1' and playing_square_id = #{winning_square_for}")
    
  end
  
  def winners(date = Date.today)

    num_groups_that_won

    winners = Array.new

    #pick winner randomly (if active)
    winner = qualifiers.rand

    winners << winner

    if num_groups_that_won > 1
    
      #pick runner up who is not in same group as winner
      runner_up_1 = qualifiers.rand
      until (runner_up_1.group_id != winners[0].group_id)
        runner_up_1 = qualifiers.rand
      end
      winners << runner_up_1
    
    end

    if num_groups_that_won > 2
      
      #pick runner up #2 who is not in same group as winner or runner up #1
      runner_up_2 = qualifiers.rand
      until (runner_up_2.group_id != winners[0].group_id) and (runner_up_2.group_id != winners[1].group_id)
        runner_up_2 = qualifiers.rand
      end
      winners << runner_up_2
    
    end

    #set awards
    awards = ["winner", "1st runner up", "2nd runner up"]

    winners.each do |w|
      
      w.update_attribute('entry_result', awards[0])
      
      #for each winner give them a title starting with winner, then if 2 give 1st runner up, then if 3 give 2nd runner up
      case awards[0]
        when "winner"
          self.winner_id = w.id
        when "1st runner up"
          self.runner_up_1_id = w.id
        when "2nd runner up"
          self.runner_up_2_id = w.id
      end

      #group members win too
      w.group.entrants.each do |group_entrant|
        if group_entrant.active == true
          group_entrant.update_attribute('entry_result', awards[0])
        end
      end

      awards.shift

    end
    
    winners = Entrant.find(:all, :conditions => "#{entry_valid_between} and (entry_result = 'winner' or entry_result = '1st runner up' or entry_result = '2nd runner up') and active = '1'")
 
  end
  
  def Draw.isOpen?

    now = Time.now

    if now.hour >= 15
        startofdraw = Time.mktime(now.year, now.month, now.day, 14, 00, 0, 0)+86400
        endofdraw = Time.mktime(now.year, now.month, now.day, 15, 00, 0, 0)+86400
    else
        startofdraw = Time.mktime(now.year, now.month, now.day, 14, 00, 0, 0) 
        endofdraw = Time.mktime(now.year, now.month, now.day, 15, 00, 0, 0)
    end

    if startofdraw < now and now < endofdraw
         return "closed"
    else
         return "open"
    end

  end
  
 

  def entrants_list(date = Date.today)

    if File.exists?("#{RAILS_ROOT}/entrants/" + date.to_s + ".csv")
      File.delete("#{RAILS_ROOT}/entrants/" + date.to_s + ".csv")
    end
    # write out email file 
    f = File.open(RAILS_ROOT + '/entrants/' + date.to_s + ".csv", 'w')

    #create the entrants list string
    entrants_list = String.new
    loser_list = String.new
    qualifier_list = String.new

    entrants_for(date = Date.today).each do |p|
      #add data to entrants list string
      
      result = 0
      
      case p.entry_result
        when "1st runner up"
          result = 1
        when "2nd runner up"
          result = 1  
        when "qualifier"
          result = 1
        when "loser"
          result = 0
      end
      
      if p.entry_result != "winner"

        string = p.email + '|' + (p.name || '') + '|' + result.to_s + '|' + 'ORANGE_STB' + "\r\n"
      
        if result == 0
          loser_list << string
        else 
          qualifier_list << string
        end

      end      
      
    end
    
    entrants_list = qualifier_list + loser_list

    f.write(entrants_list)
    
    f.close
    
    entrants_for(date = Date.today)

  end
  
  def num_groups_that_won
 
     number_of_groups_that_won = Entrant.find_by_sql("select distinct group_id from entrants where entry_result = 'qualifier' and  #{entry_valid_between} and active = '1'").size

  end


  def generate_stats(date = Date.today)
    
     if File.exists?("#{RAILS_ROOT}/stats/" + date.to_s + ".csv")
        File.delete("#{RAILS_ROOT}/stats/" + date.to_s + ".csv")
      end
      # write out email file 
      f = File.open(RAILS_ROOT + '/stats/' + date.to_s + ".csv", 'w')

      
      _entrants = 0
      _4personteams = 0
      _3personteams = 0
      _2personteams = 0
      _1personteams = 0

      buffer = String.new

      _entry_valid_after  = date.yesterday.to_s + " 15:00:00"
      _entry_valid_before = date.to_s + " 14:00:00"
      _entry_valid_between = "created_at >= '#{_entry_valid_after}' AND created_at < '#{_entry_valid_before}'"
      
      
      entrants = Entrant.find(:all, :conditions => "#{_entry_valid_between} and active = 1")
      
      _entrants = entrants.length
      
      entrants.each do |p|
      
   
      if p.group.originator_id == p.id      
        
       
        case p.group.entrants.length
          when 1
            _1personteams = _1personteams+1
          when 2
            _2personteams = _2personteams+1
          when 3
            _3personteams = _3personteams+1
          when 4
            _4personteams = _4personteams+1
        end

        end      

      end

      _buffer = date.to_s+ ',' +_entrants.to_s + ',' + _1personteams.to_s + ',' + _2personteams.to_s + ',' + _3personteams.to_s + ',' + _4personteams.to_s   + "\n"
      buffer << _buffer

      f.write(buffer)

      f.close
  end

end
