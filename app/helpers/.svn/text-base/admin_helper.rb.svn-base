module AdminHelper
  def winners(qualifiers)
    @winner = Array.new
    @first_runner_up = Array.new
    @second_runner_up = Array.new
    
    qualifiers.each do |qualifier|
      case qualifier.entry_result
      when /winner/ then @winner << qualifier
      when /1st runner up/ then @first_runner_up << qualifier
      when /2nd runner up/ then @second_runner_up << qualifier
      end
    end
  end
  
  def count_qualifiers(entrants)
    qualifiers = entrants.find(:all, :conditions => 'entry_result = "qualifier"')
    qualifiers.nil? ? 0 : qualifiers.size
  end
end
