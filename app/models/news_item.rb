#require 'mini_magick'

class NewsItem < ActiveRecord::Base

    attr_accessor :tmpmediafile
    has_one :media_item
    has_one :bull_location
    
    validates_presence_of :title, :description
    
    #TODO: this validation on media_item image size needs to reflect the fact that we are using attachment_fu and storing the image as a media item 

=begin
    def validate
        
        if image != nil

            pic = Magick::Image.from_blob(image)[0]
            picw = pic.columns
            pich = pic.rows

            
            if itemtype == "Tales From The Field"
                if picw != 132 && pich != 72 
                    errors.add(:image, "The image needs to be 132x72 pixels.")
                end
            else
            
                if picw != 32 && pich != 32 
                    errors.add(:image, "The image needs to be 32x32 pixels.")
                end
            end
        end
    end
=end 
        
end