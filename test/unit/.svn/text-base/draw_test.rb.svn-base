require File.dirname(__FILE__) + '/../test_helper'
require 'mocha'

class DrawTest < ActiveSupport::TestCase

  
  def some_locations
    
    #create two locations
    BullLocation.create!(:x => 234, :y => 324, :playing_square_id => 31)
    BullLocation.create!(:x => 234, :y => 324, :playing_square_id => 32)
    
  end
 
  def three_winners_one_inactive_shared_group
    
    g = Entrant.create!(:email => "test1@pokelondon.com", :active => 1, :playing_square_id => 32)
    #same group in active
    Entrant.create!(:email => "test2@pokelondon.com", :active => 0, :group_id => g.group.id, :playing_square_id => 32)
    Entrant.create!(:email => "test3@pokelondon.com", :active => 1, :playing_square_id => 32)
    Entrant.create!(:email => "test6@pokelondon.com", :active => 1, :playing_square_id => 32)
       
  end
 

  # Replace this with your real tests.
  def test_simulate_draw
  
    #set time at 1pm before draw
    new_now = Time.now.change(:hour => 13)
    Time.stubs(:now).returns(new_now)
    
    #guessed right
    sg = Entrant.create!(:email => "test1@pokelondon.com", :active => 1, :playing_square_id => 32)
    Entrant.create!(:email => "test2@pokelondon.com", :active => 1, :group_id => sg.group.id, :playing_square_id => 32)
    Entrant.create!(:email => "test3@pokelondon.com", :active => 1, :playing_square_id => 32)
    Entrant.create!(:email => "test6@pokelondon.com", :active => 1, :playing_square_id => 32)
    Entrant.create!(:email => "test7@pokelondon.com", :active => 1, :playing_square_id => 32)

    #duplicate attempt should fail
    e = Entrant.new(:email => "test1@pokelondon.com", :active => 1, :playing_square_id => 32)
    assert !e.save
    
    #guessed wrong
    Entrant.create!(:email => "test4@pokelondon.com", :active => 1, :playing_square_id => 31)

    #should be 4 entrants. 3 qualifiers.

    some_locations #get some locations
    
    #set time at 3pm for draw
    new_now = Time.now.change(:hour => 15)
    Time.stubs(:now).returns(new_now)
    
    d = Draw.new
    
    #winning sqaure is last for todays draw
    assert_equal 32, d.winning_square_for
    
    #5 qualify (of other 2, 1 wrong time, 1 wrong square)
    assert_equal 5, d.qualifiers.size
    
    assert d.generate

  end
  
  def test_not_active_friends_cant_win

    #set time at 2pm before draw
    new_now = Time.now.change(:hour => 13)
    Time.stubs(:now).returns(new_now)
    
    three_winners_one_inactive_shared_group #get some entrants
    
    some_locations #get some locations    
    
    #set time at 3pm for draw
    new_now = Time.now.change(:hour => 15)
    Time.stubs(:now).returns(new_now)
    
    d = Draw.new
    
    #winning sqaure is last for todays draw
    assert_equal 32, d.winning_square_for
    
    assert_equal 3, d.qualifiers.size
    
    assert_equal 3, d.winners.size   
    
    assert d.generate
   
    
  end


  def test_active_friends_win_too
    
    #set time at 1pm before draw
    new_now = Time.now.change(:hour => 13)
    Time.stubs(:now).returns(new_now)

    #create 50 entrants each with a different square
    5.times do |i|
      Entrant.create!(:email => "test_user_#{i}@pokelondon.com", :active => 1, :playing_square_id => (i+1))
    end
  
    #create friends of user test_user_1
    3.times do |e|
      Entrant.create!(:email => "friend#{e}@pokelondon.com", :group_id => Entrant.find_by_email("test_user_1@pokelondon.com").group_id, :playing_square_id => 1, :active => 1)
    end

    #create two other entrants with same square otherwise draw wont run
    2.times do |e|
      group_id = (Group.create).id
      Entrant.create!(:email => "random_#{e}@pokelondon.com", :group_id => group_id, :playing_square_id => 1, :active => 1)
    end

    BullLocation.create!(:x => 234, :y => 324, :playing_square_id => 31)
    BullLocation.create!(:x => 234, :y => 324, :playing_square_id => 1)

    #set time at 1pm before draw
    new_now = Time.now.change(:hour => 15)
    Time.stubs(:now).returns(new_now)

    d = Draw.new
    assert_equal 1, d.winning_square_for

    assert_equal 4, Entrant.find_by_email("test_user_1@pokelondon.com").group.entrants.size

    #how many winners #=> 6
    assert_equal 6, d.winners.size    
    #find all distinct group ids who have won #=>3
    assert_equal 3, Entrant.find(:all, :select => "DISTINCT group_id", :conditions => "entry_result = 'winner' or entry_result = '1st runner up' or entry_result = '2nd runner up' ").size
    #3 group_ids from 6 winners == active friends win too!
    
    #assert_equal 6, d.qualifiers.size
    assert_equal 10, d.entrants_list.size
    assert File.exists?("#{RAILS_ROOT}/entrants/" + Date.today.to_s + ".csv")
    assert d.generate
    assert f = File.open("#{RAILS_ROOT}/entrants/" + Date.today.to_s + ".csv")
    assert_equal 10, f.read.count('@') #number of email addresses = number of entrants #=> therefore 10 entrants

  end  
  
  
  def test_z_can_redraw_same_day?
  
    #set time at 1pm before draw
    new_now = Time.now.change(:hour => 13)
    Time.stubs(:now).returns(new_now)
    
    #create 5 entrants each with a different square
    5.times do |i|
      Entrant.create!(:email => "test_user_#{i}@pokelondon.com", :active => 1, :playing_square_id => (i+1))
    end
  
    #create friends of user test_user_1
    3.times do |e|
      Entrant.create!(:email => "friend#{e}@pokelondon.com", :group_id => Entrant.find_by_email("test_user_1@pokelondon.com").group_id, :playing_square_id => 1, :active => 1)
    end

    #create two other entrants with same square otherwise draw wont run
    2.times do |e|
      Entrant.create!(:email => "random_#{e}@pokelondon.com", :playing_square_id => 1, :active => 1)
    end

    BullLocation.create!(:x => 234, :y => 324, :playing_square_id => 31)
    BullLocation.create!(:x => 234, :y => 324, :playing_square_id => 1)

    #set time at 1pm before draw
    new_now = Time.now.change(:hour => 15)
    Time.stubs(:now).returns(new_now)

    d = Draw.new
    #assert f = File.open("#{RAILS_ROOT}/entrants/" + Date.today.to_s)
    #assert_equal 10, f.read.count('@') #number of email addresses = number of entrants #=> therefore 10 entrants
    assert_equal 6, d.qualifiers.size
    
    d.generate
    
    r = Array.new
    CSV.open("#{RAILS_ROOT}/entrants/" + Date.today.to_s + ".csv", 'r') do |row|
      r << row[3]
    end
        
    #winning square is 1
    assert_equal 1, d.winning_square_for
    
    #FIRST DRAW HAS 6 WINNERS
    assert_equal 6, d.winners.size

    
    #REDRAW HERE!
    
    Entrant.delete_all

    #set time at 1pm before draw
    new_now = Time.now.change(:hour => 13)
    Time.stubs(:now).returns(new_now)

    #create 5 entrants each with a different square
    5.times do |i|
      Entrant.create!(:email => "test_user_#{i}@pokelondon.com", :active => 1, :playing_square_id => (i+1))
    end

    #create friends of user test_user_1
    3.times do |e|
      Entrant.create!(:email => "friend#{e}@pokelondon.com", :group_id => Entrant.find_by_email("test_user_1@pokelondon.com").group_id, :playing_square_id => 1, :active => 0)
    end

    #create two other entrants with same square otherwise draw wont run
    2.times do |e|
      group_id = (Group.create).id
      Entrant.create!(:email => "random_#{e}@pokelondon.com", :group_id => group_id, :playing_square_id => 1, :active => 1)
    end

    BullLocation.create!(:x => 234, :y => 324, :playing_square_id => 31)
    BullLocation.create!(:x => 234, :y => 324, :playing_square_id => 1)

    #set time at 3pm for draw
    new_now = Time.now.change(:hour => 15)
    Time.stubs(:now).returns(new_now)

    d = Draw.new  
    
    #only 3 qualify because friends are inactive this time
    assert_equal 3, d.qualifiers.size
    
    d.generate
    
    assert_equal 7, d.entrants_list.size
    
    
    assert f = File.open("#{RAILS_ROOT}/entrants/" + Date.today.to_s + '.csv')
    
    #assert csv is being rewritten correctly    
    r = Array.new
    CSV.open("#{RAILS_ROOT}/entrants/" + Date.today.to_s + ".csv", 'r') do |row|
      r << row[3]
    end
    
    #SECOND DRAW HAS 6 WINNERS
    assert_equal 3, d.winners.size
    
    assert_equal 1, r.select {|x| x == 'winner'}.length
    assert_equal 1, r.select {|x| x == '1st runner up'}.length    
    assert_equal 1, r.select {|x| x == '2nd runner up'}.length

  end
  
  def test_draw_ignores_inactives
    
    #set time at 1pm before draw
    new_now = Time.now.change(:hour => 13)
    Time.stubs(:now).returns(new_now)
    
    BullLocation.create!(:x => 234, :y => 324, :playing_square_id => 4)  
    
    5.times do |i|
      Entrant.create!(:email => "test_user_#{i}@pokelondon.com", :active => 1, :playing_square_id => 4)
    end
    
    #not active
    Entrant.create!(:email => 'asdas@asdas.com', :playing_square_id => 4)
    
    #set time at 3pm
    new_now = Time.now.change(:hour => 15)
    Time.stubs(:now).returns(new_now)
    
    d = Draw.new
    assert_equal 4, d.winning_square_for
    assert_equal 5, d.qualifiers.size 
    d.generate
    assert_equal Date.today, d.play_date
    
    assert f = File.open("#{RAILS_ROOT}/entrants/" + Date.today.to_s + '.csv') 
    #6 created but only 5 are counted
    assert_equal 5, f.read.count('@')
    
    #show that entrant entry_result is ignored when inactive
    assert_equal 6, Entrant.find(:all).size
    assert_equal 1, Entrant.find(:all, :conditions => "entry_result IS NULL").size
    assert_equal 5, Entrant.find(:all, :conditions => "entry_result IS NOT NULL").size
    
  end

  def test_playing_square_is_only_selected_from_right_draw_period
    
    #set time at 1pm before draw
    new_now = Time.now.change(:hour => 13)
    Time.stubs(:now).returns(new_now)
 
    BullLocation.create!(:x => 234, :y => 324, :playing_square_id => 4)
    
    #set time at 1pm day before draw
    new_now = Time.now.yesterday
    Time.stubs(:now).returns(new_now)
   
    BullLocation.create!(:x => 234, :y => 324, :playing_square_id => 5)
    
    #set time at 3pm day at draw
    new_now = Time.now.tomorrow.change(:hour => 15)
    Time.stubs(:now).returns(new_now)
    
    d = Draw.new
    assert_equal 4, d.winning_square_for
        
    
  end
  
  def test_right_number_of_winners_when_friends_are_both_active_and_inactive
  
    #set time at 1pm before draw
    new_now = Time.now.change(:hour => 13)
    Time.stubs(:now).returns(new_now)

    BullLocation.create!(:x => 234, :y => 324, :playing_square_id => 4)   
    
    #create 1 entrant
    user = Entrant.create!(:email => "test_user_1@pokelondon.com", :active => 1, :playing_square_id => 4)

    #create 2 friends of user test_user_1 #=> 1 active 1 inactive
    2.times do |e|
      Entrant.create!(:email => "friend#{e}@pokelondon.com", :group_id => user.group_id, :playing_square_id => 4, :active => e)
    end
    
    #create 2 other winners - bcos u need 3 diff winners minimum
    2.times do |o|
      Entrant.create!(:email => "others_#{o}@pokelondon.com", :active => 1, :playing_square_id => 4) 
    end

    #set time at 3pm before draw
    new_now = Time.now.change(:hour => 15)
    Time.stubs(:now).returns(new_now)
     
    d = Draw.new
    assert d.generate
    assert_equal 4, d.winners.size
 
  end
  
  def test_bull_locations_after_deadline_are_not_counted
    
    #set time at 1pm before draw
    new_now = Time.now.change(:hour => 13)
    Time.stubs(:now).returns(new_now)
    
    some_locations
    
    #set time at 3pm before draw
    new_now = Time.now.change(:hour => 15)
    Time.stubs(:now).returns(new_now)
    
    BullLocation.create!(:x => 34, :y => 32, :playing_square_id => 2)
    
    d = Draw.new
    assert_equal 32, d.winning_square_for
    
    
  end
  

end
