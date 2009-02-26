class BullLocation < ActiveRecord::Base

  belongs_to :playing_square
  belongs_to :news_item

  def BullLocation.winningZoneForDraw(startofdraw,endofdraw)
      loc = BullLocation.find(:first,:conditions=>["created_at >= ? and created_at < ?","#{startofdraw.to_s:db}","#{endofdraw.to_s:db}"], :order=>'created_at DESC')
      return loc
  end 
  
  def location_info
    "#{created_at.strftime("%A %H:%M")}" + ' : ' +
    "Square #{playing_square_id}" + ' : ' +
    "x#{x}" + " y#{y}"
  end

end