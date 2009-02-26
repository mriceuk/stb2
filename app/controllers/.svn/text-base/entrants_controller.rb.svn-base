class EntrantsController < ApplicationController
  
  layout "no_flash"
  
  before_filter :validate_input, :only => [:create]
  before_filter :validate_update_square, :only => [:update_square]

  def create
 
    @entrant = Entrant.new(params[:entrant])  
    @entrant.ip_address = request.remote_addr
    
    if @entrant.save
      #flash[:notice] = "Congratulations! You have been entered into the competition to win Glastonbury Tickets."
      #redirect_to group_path(@entrant.group)
    else
      flash[:notice] = @entrant.errors.on_base
      redirect_back

    end
  
  end

  def validate_input 
    
    flash[:notice] = String.new
    
    if Time.now.hour == 14
      flash[:notice] << "The game is closed between 2pm and 3pm<br>"
    end

    if params[:entrant][:name].blank?
      flash[:notice] << "Please enter a name<br>"
      errors = true
    end

    if params[:entrant][:mobile].blank?
      flash[:notice] << "Please enter a mobile number<br>"
      errors = true
    end
    
    if params[:entrant][:terms] != "agreed"
      flash[:notice] << "You must accept the terms and conditions<br>"
      errors = true
    end

    if params[:entrant][:email].blank?
      flash[:notice] << "Please enter an email address<br>"
      errors = true
    end

    unless params[:entrant][:email] =~ %r{^[a-zA-Z][\w\.-]*[a-zA-Z0-9]@[a-zA-Z0-9][\w\.-]*[a-zA-Z0-9]\.[a-zA-Z][a-zA-Z\.]*[a-zA-Z]$}
      flash[:notice] << "Your email address appears to be invalid<br>"
      errors = true
    end

    if params[:entrant][:playing_square_id].blank?
      flash[:notice] << "Please select a playing square<br>"
      errors = true
    end
    
    if errors == true then redirect_back end

  end
  
  def invitee
  
    unless uid = (params[:invite] || params[:uid] || params[:id])
      render :text => "UID missing" 
      return
    end

    unless @uid = Uid.find_by_uid(uid)
      render :text => "This UID is invalid"
      return
    end

    unless @entrant = @uid.entrant
      render :text => "Entrant could not be found with this UID"
      return
    end

    unless @entrant.playing_square_id.blank?
      render :text => "You have already chosen a playing square"
      return
    end

    if @entrant
      @originator = Entrant.find(@entrant.group.originator_id)
      @squares = Array.new
      @entrant.group.entrants.each do |e|
        if e.playing_square_id.full?
          @squares << e.playing_square_id
        end
      end
      @squares_list = @squares.collect {|s| s.to_s + ' ' }
    end
    
  end
  
  def select_square
    
    unless uid = (params[:invite] || params[:uid] || params[:id])
      render :text => "UID missing" 
      return
    end

    unless @uid = Uid.find_by_uid(uid)
      render :text => "This UID is invalid"
      return
    end

    unless @entrant = @uid.entrant
      render :text => "Entrant could not be found with this UID"
      return
    end

    unless @entrant.playing_square_id.blank?
      render :text => "You have already chosen a playing square"
      return
    end
  
    if @entrant
      @originator = Entrant.find(@entrant.group.originator_id)
    end
        
  end
  
  def new
    if flash[:notice].full? 
      @msg = "Oops. Check the highlighted boxes for mistakes or bits you've missed."
      if flash[:notice].match("Hotmail")
        @msg = "sorry, our emails aren't getting through to
        Hotmail<br> at the moment but you can still play
        (please use another email address)"
      end
      if flash[:notice].match("2pm")
        @msg = "form could not be submitted at this time"
      end
    end
    
    @entrant = Entrant.new
  end
  
  def update_square
     
    @entrant = Entrant.find(params[:entrant][:id])

    #can only update if playing_square_id is empty - changing playing_square_id is not permitted
    if @entrant.playing_square_id.blank? and @entrant.group_id.full?
    
      @entrant.active = true
      
      if @entrant.update_attributes(params[:entrant])
      
        flash[:notice] = "Thanks for completing your participation in today's game"

        #tell use they have played and what square they picked
        BullMailer.deliver_confirm(@entrant)
        
        @entrant.group.entrants.each do |e|
          if (e.active == true) and (e.id != @entrant.id)
            BullMailer.deliver_team_confirm(e, @entrant)
          end
        end

      else 
        flash[:notice] = @entrant.errors.on_base
        redirect_back({"action"=>:select_square, "controller"=>"entrants"})
      end

    else 

      flash[:notice] = "You have already chosen a square<br>"
      redirect_back({"action"=>:select_square, "controller"=>"entrants"})

    end

  end
  
  def confirmation
    @entrant = Entrant.find(params[:id])
    
    if @entrant.active == false
    
      if @entrant.update_attribute('active', 1)
        BullMailer.deliver_confirm(@entrant)
      else 
        redirect_back
        return
      end
    
    end
    
    
  end
  
  private
  
  def originator_cant_use_hotmail
    
    if params[:entrant][:email].match('hotmail|Hotmail')
      flash[:notice] << "Hotmail email accounts are incompatible with this site."
      errors = true
      redirect_back
    end
  end
  
  def validate_update_square
  
    flash[:notice] = String.new
  
    if params[:entrant][:mobile].blank?
      flash[:notice] << "Please enter a mobile number<br>"
      errors = true
    end
  
    if params[:entrant][:terms] != "agreed"
      flash[:notice] << "You must accept the terms and conditions<br>"
      errors = true
    end
    
    if params[:entrant][:playing_square_id].blank?
      flash[:notice] << "Please select a playing square<br>"
      errors = true
    end
    
    if Time.now.hour == 14
      flash[:notice] << "The game is closed between 2pm and 3pm<br>"
    end

    if params[:entrant][:name].blank?
      flash[:notice] << "Please enter a name<br>"
      errors = true
    end
    
    if errors == true
      redirect_back({"action"=>:select_square, "controller"=>"entrants"})
    end
  
  end


=begin
#should not be needed as validation exists at the model level MR

  # TODO this custom filter doesn't work yet - MT 
  def validate_on_create
      # today = Time.now.to_date.to_s
      # #the last time from which to take the bull position from
      # if Time.now.hour < 14
      #   after = "created_at >= '" + Time.today.yesterday.yesterday.to_date.to_s + " 15:00:00'"
      #   before =  "created_at <= '" + Time.today.to_date.to_s + " 14:00:00'"
      # else
      #   after = "created_at >= '" + Time.today.yesterday.to_date.to_s + " 15:00:00'"
      #   before =  "created_at <= '" + Time.today.tomorrow.to_date.to_s + " 14:00:00'"
      # end
      # 
      # time_constraint_this_draw = after + ' and ' + before  
      # 
      # @entry = Entrant.find(:first, :conditions => time_constraint_this_draw + " AND email = '#{params[:entrant][:email]}'")
      # if @entry
      #   flash[:notice] = "You have already entered today (you picked zone: #{@entry.playing_square_id})."
      #   errors = true
      #   false
      # end
    end
=end

end

