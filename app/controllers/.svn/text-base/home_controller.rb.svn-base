class HomeController < ApplicationController

  layout "no_flash"

  def index

    if Time.now.hour == 14
      render :text => "<h4 id='error_text'>The game is closed between 2pm and 3pm</h4>"
    end

  end

end