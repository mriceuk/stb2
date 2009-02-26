class Uid < ActiveRecord::Base

  belongs_to :entrant,:include=>"group"
  
  after_create :setUniqueCode

  attr_accessor :codetype
   
  def setUniqueCode
      self.uid = generateCode
      self.save

      while not iscodeunique?
          self.uid = generateCode
      end

      self.save
  end
  
  def iscodeunique?
  
    codes = Uid.find(:all, :conditions => ["uid = ?",self.uid.upcase])

    if codes.length > 1
        return false
    else
        return true
    end

  end

  def generateCode()

    length = 5
    digitArray = Array.new(length)
    digitArray.fill{ |i| randomRange(0..15) }

    sum = 0
    pos = 0

    while pos < length-1

      odd = digitArray[pos] * 2

      if odd > 9
        odd -= 9
      end
      
      sum += odd

      if pos != (length - 2)
        sum += digitArray[pos+1]
      end

      pos += 2

    end

    checksumdigit = (((sum/10).to_f.floor + 1) * 10 - sum) % 10;
    digitArray << checksumdigit
    exportstring = ''

    digitArray.each do |digit|
        exportstring += sprintf("%X", digit)
    end

    #exportstring.insert 0
    exportstring.upcase

      
  end
   
  def randomRange(r)
       r.first + rand(r.last - r.first + (r.exclude_end? ? 0 : 1))
  end
  
end
