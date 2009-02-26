# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper
  
  def error_if(string, hash = false)
    
    if flash[:notice] and flash[:notice].match(string)
      'style="color:red;"'
    end
  end
end
