class GroupsController < ApplicationController

  layout "no_flash"

  before_filter :is_group_valid?, :only => [:update]
  before_filter :are_invitees_valid?, :only => [:update]
  before_filter :at_least_one_friend?, :only => [:update]
  before_filter :is_time_2?, :only => [:update]

  
  def show
    @group = Group.find(params[:id])
    @entrant = Entrant.find(@group.originator_id)
    @msg = flash[:notice]
  end
  
  def update

    #dont allow it if entrants greater than 1 or if friends is larger than 

    @group = Group.find(params[:group_id])

    friends = params[:friends]
    originator = Entrant.find(@group.originator_id)
    originator.update_attribute("active", 1)

    unless (@group.entrants.size > 1 or friends.size > 3)

      collection = String.new
      friends.each do |f|
        unless f.blank?
          e = Entrant.new(:email => f, :group_id => params[:group_id])
          if e.save
            BullMailer.deliver_invite(e, originator)
          end
        end
      end
    
      BullMailer.deliver_initiator(originator)
      redirect_to :action => 'invited', :id => @group.id
      
    else
      flash[:notice] = "Your friends could not be added, you are only allowed to add 3 friends, friends can only be invited once"
      redirect_back({:controller => "groups", :id => params[:group_id]})
    end

  end
  
  def invited
    @group = Group.find(params[:id])
  end
  
  def new
  
  end
  
  private
  
  def are_invitees_valid?
    friends = params[:friends]

    friends.each do |f|
      if validate_invitee(f) == false
        redirect_back({:controller => "groups", :id => params[:group_id]})
        return
      end
    end
  end
  
  def validate_invitee(f)

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

    @entrant = Entrant.find(:first, :conditions => ["email = ? and created_at >= ? and created_at < ?", f, todaysStart, todaysEnd])
    #debugger
    if @entrant
      flash[:notice] = "#{f} has already played today!<br>"
      return false
    end

  end
  
  def is_group_valid?

    g = Group.find(params[:group_id])
    created_at = g.created_at

    if created_at.hour >= 15
      startofdraw = Time.mktime(created_at.year, created_at.month, created_at.day, 15, 00, 0, 0)
      endofdraw = Time.mktime(created_at.year, created_at.month, created_at.day, 14, 00, 0, 0) + 86400
    else
      startofdraw = Time.mktime(created_at.year, created_at.month, created_at.day, 15, 00, 0, 0) - 86400
      endofdraw = Time.mktime(created_at.year, created_at.month, created_at.day, 14, 00, 0, 0)
    end

    end_of_draw = Time.now.yesterday

    if (Time.now > endofdraw)
      flash[:notice] = "You can not complete your entry at this time as the deadline for the draw you were entered into has passed<br>"
      redirect_back({:controller => "groups", :id => params[:group_id]})
      return
    end
    
  end
  
  def at_least_one_friend?
    at_least_one_friend = false
    friends = params[:friends]
    
    friends.each do |f|
      if f.full?
        at_least_one_friend = true
      end
    end
    
    if at_least_one_friend == false then flash[:notice] = "You must enter at least one email address"; redirect_back end
    
  end
  
  def is_time_2?
    if Time.now.hour == 14
      flash[:notice] = "No entrants could be added because the draw deadline has passed."
      redirect_back
      return
    end
  end
  
  def originator_cant_use_hotmail
    
    friends = params[:friends]
    friends.each do |f|
      if f.match('hotmail|Hotmail')
        flash[:notice] = "sorry, our emails aren't getting through to
        Hotmail<br> at the moment but you can still play
        (please use another email address)"
        redirect_back
      end
    end
  
  end
  
end
