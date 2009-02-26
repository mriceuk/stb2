class BullPositionsController < ApplicationController

  before_filter :recognize_location
  before_filter :is_logged_in?

  def recognize_location
    session[:referer] = '/bull_positions'   
  end

  def index
    @positions = BullLocation.find(:all, :order => "created_at DESC", :limit => 10)
  end
  
end
