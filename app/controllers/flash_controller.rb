class FlashController < ApplicationController

   def index   
 
        if session[:invitation] 
          @uid = session[:invitation]
          session[:invitation] = nil
          
    
        else
          session[:invitation] = nil
          @uid = nil
        end
        
        @date = Time.now.to_s:db
    end
end
