class AdminController < ApplicationController
  
  before_filter :recognize_location  
  before_filter :is_logged_in?

  
  def recognize_location
    session[:referer] = '/admin'    
  end
  
  def index
    @deadline = draw_deadline
    @entrants_total = Entrant.find(:all, :conditions => 'active = 1')
    @entrants_today = find_entrants
    @bull_position = BullLocation.find(:first, :order => "created_at DESC")
  end
  
  def login
  end
  
  def add_location
    BullLocation.create(params[:location])
    flash[:notice] = "Hooray! Location added."
    redirect_to :action => 'bull_positions'
  end
  
  def bull_positions
    @positions = BullLocation.find(:all, :order => "created_at DESC", :limit => 10)
  end
  
  def news
    @news_item = NewsItem.new
    @media_item = MediaItem.new
    @bull_locations = BullLocation.find(:all)
    @news_items = NewsItem.find(:all, :order => 'created_at DESC')
  end
  
  def create_news
    @news_item = NewsItem.new(params[:news_item])
    @media_item = MediaItem.new(params[:media_item])
    
    @news_item.media_type = get_media_type(@media_item.filename)
        
    @news_item.bull_location = @bull_location

    
    if @news_item.save
      @news_item.media_item = @media_item
      if @media_item.save
      end
      unless @news_item.bull_location_id == nil
        @bull_location = BullLocation.find(@news_item.bull_location_id)
        @news_item.bull_location = @bull_location
      end
      flash[:notice] = "Your news item has been saved."
    else
      flash[:notice] = "There was a problem saving your news item."
      @news_item.errors.save
    end
    
    redirect_to(news_path)
  end
  
  def edit_news
    @news_item = NewsItem.find(params[:id])
    if @news_item.media_item
      @media_item = @news_item.media_item
    end
    @bull_locations = BullLocation.find(:all, :order => "id DESC", :limit => "0,10")
  end
  
  def update_news
    @news_item = NewsItem.find(params[:id])
    @news_item.update_attributes(params[:news_item])
    
    if @news_item.errors.empty?
      # if there's already a media item, fetch it
      if @news_item.media_item
        @media_item = @news_item.media_item
        @media_item.update_attributes(params[:media_item])
        update_media_type(@news_item, @media_item)
      # otherwise create a new media item from params
      else
        @media_item = MediaItem.new(params[:media_item])
        @media_item.news_item_id = @news_item.id
        @media_item.save
        update_media_type(@news_item, @media_item)
      end
      unless @news_item.bull_location_id == nil
          @bull_location = BullLocation.find(@news_item.bull_location_id)
        @news_item.bull_location = @bull_location
      end
      flash[:notice] = "Your news item has been updated."
    else
      flash[:notice] = "Whoops! There was a problem updating your news item."
    end
    redirect_to :action => 'edit_news', :id => @news_item
  end
  
  def new_draw
    
    @last_draw = Draw.find(:first, :order => 'created_on DESC')
    
    if @last_draw
      
      @qualifiers = Entrant.find(:all, :conditions => "draw_id = #{@last_draw.id}")
      # winners for the most recent drawing
      winners(@qualifiers)
      
      
      @winner = Entrant.find(@last_draw.winner_id)
      if @last_draw.runner_up_1_id
      @runner_up_1 = Entrant.find(@last_draw.runner_up_1_id)
      end
      if @last_draw.runner_up_2_id
      @runner_up_2 = Entrant.find(@last_draw.runner_up_2_id)  
      end
      
    end
    
  end
  
  def draw(date = Date.today)
    
    @draw = Draw.new
    if @draw.generate(date) 
      flash[:notice] = "Draw complete!"
    else
    
      flash[:notice] = "Draw could not be completed<br>" 
    
      flash[:notice] << "Possible Failures:<br>winning square: #{@draw.winning_square_for}<br>" 
    
      if @draw.winning_square_for
        flash[:notice] << "qualifiers:#{@draw.qualifiers_list.size}"
      end
    
    end
    
    redirect_to :action => 'new_draw'
    
  end
  
  def delete_news
    @news = NewsItem.find(params[:id])
    if @news.destroy 
      flash[:notice] = "Article " + @news.title.titlecase + " deleted."
      redirect_to :back
    end
  end
  
  def reports
    @draws = Draw.find(:all, :order => 'created_on DESC')

    @entrants = Entrant.find(:all, :conditions => 'active = 1')
    @noplay = Entrant.find(:all, :conditions => 'active = 0')
    
    # get entrant stats
    @uniques = Array.new
    @entrants.each do |entrant|
      @uniques << entrant.email
    end
    
    @uniques = @uniques.uniq.size
    
    # get group stats
    @groups = Group.find(:all)
    @active_groups = Array.new
    @group_avg = 0
    @groups.each do |group|
      if group.entrants.size > 1
        @active_groups << group
        @group_avg += group.entrants.size
      end
    end
    @active_count = 0
    @active_groups.each do |group|
      @active_count += 1
    end
    # return number of active groups
    @active_count - @active_groups.size
    if @group_avg > 0 and @active_count > 0
    @group_avg = @group_avg / @active_count
    end
    
  end
  
end
