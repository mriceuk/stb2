class GameController < ApplicationController

  def index
  	session[:invitation] = nil
     if params[:invitation]
         session[:invitation] = params[:invitation]
     end
     redirect_to :controller=>"flash/index"
   end

end
