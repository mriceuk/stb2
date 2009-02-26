# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  # Pick a unique cookie name to distinguish our session data from others'
  session :session_key => '_stb2_session_id'
  
  class::Object
    def full?
      blank? ? nil : self
    end
  end
  
  
  class::Time
    def now
      'today'
    end
  end
  
  def is_authenticated
    if session[:user_id]
      true
    else
      false
    end

  end
  
  def is_admin
    return false
   if is_authenticated == true
      admin_status = User.find(session[:user_id]).is_admin
      if admin_status == 1
        true
      else
        false
      end
    else
      false
    end
  end
  
  def redirect_if_not_authenticated
    store_previous_url
    if is_authenticated == false
      redirect_to login_url
    end
  end

  def redirect_if_not_admin
    if is_admin == false
      redirect_to '/'
      #login_url
    end
  end
  
  def entry_valid_after(date = Date.today)
    date.yesterday.to_s + " 15:00:00"
  end
  
  def entry_valid_before(date = Date.today)
    date.to_s + " 14:00:00"
  end
  
  def entry_valid_between(date = Date.today)
     entry_valid_between = "created_at >= '#{entry_valid_after(date)}' AND created_at <= '#{entry_valid_before(date)}'"
  end
  
  def find_entrants(date = Date.today)
    # build SQL condition based on date
    entrants = Entrant.find(:all, :conditions => "#{entry_valid_between(date)}")
  end
  
  def draw_deadline
    today = Date.today.to_s
    tomorrow = Date.tomorrow.to_s

    if Time.now.hour < 14
      deadline = today + " 15:00:00"
    else
      deadline = tomorrow + " 15:00:00"
    end
  end
  
  def get_media_type(filename)
    case filename 
    when /.*(jpg|gif|png)$/ then "image"
    when /.*(flv)$/ then "video"
    else "text"
    end
  end
  
  def update_media_type(news_item, media_item)
    if media_item.id == nil
      news_item.update_attribute(:media_type, "text")
    else
      news_item.update_attribute(:media_type, get_media_type(media_item.filename))
    end
  end

 
  def winners(qualifiers)
    qualifiers.each do |qualifier|
      case qualifier.entry_result
      when /winner/ then @winner = qualifier
      when /1st runner up/ then @first_runner_up = qualifier
      when /2nd runner up/ then @second_runner_up = qualifier
      end
    end
  end
  


  
  private
  
  def redirect_back(redirect_opts = nil)
    redirect_opts ||= {:controller => 'home', :action => "index"}
    request.env["HTTP_REFERER"] ? redirect_to(request.env["HTTP_REFERER"]) : redirect_to(redirect_opts)
  end
  
  def is_logged_in?  
    if session[:user_id].blank? then redirect_to login_path end
  end
  
end