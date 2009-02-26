require "#{File.dirname(__FILE__)}/../test_helper"

class GameSimulationTest < ActionController::IntegrationTest

  def test_simulate_the_game
  
    set_time(13)
  
    #each picks different square starting with 1
    get_random_users(10)
    
    #2 other people
    Entrant.create!(:email => "emailasd@poke.com", :terms => "agreed", :mobile => '2312', :name => "user_rand", :playing_square_id => 1, :active => true)
    Entrant.create!(:email => "emailwsd@poke.com", :terms => "agreed", :mobile => '2312', :name => "user_rand", :playing_square_id => 1, :active => true)
    
    #winning bull location to be square #1
    create_bull_location(1)
    
    assert_equal 1, BullLocation.find(:all).size
    
    #make time 3pm for draw
    set_time(15)
    
    d = Draw.new
    assert_equal 1, d.winning_square_for
    #assert_equal 3, d.qualifiers_list.size
    assert d.generate
    
  end
  
  
  
  
  private
  
  def create_bull_location(playing_square_id)
  
    BullLocation.create(:x => 32, :y => 23, :playing_square_id => playing_square_id)
  
  end
  
  def get_random_users(users)
  
    users.times do |u|

      get "home"
      assert_template "home/index"
      post "/entrants/", :entrant => { :email => "email#{u}@poke.com", :terms => "agreed", :mobile => '2312', :name => "user#{u}", :playing_square_id => (u+1) }
      id = Entrant.find(:first, :order => "created_at DESC").id
      assert_redirected_to "/groups/show/" + id.to_s
      post "/groups/confirmation/" + id.to_s


    end

    #x users created
    assert_equal users, Entrant.find(:all).size    
    
  end
  
  def set_time(hour)
  
    new_now = Time.now.change(:hour => hour)
    Time.stubs(:now).returns(new_now)
  
  end
  
end
