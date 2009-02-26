require File.dirname(__FILE__) + '/../test_helper'
require 'mocha'

class EntrantsControllerTest < ActionController::TestCase
  # Replace this with your real tests.
  
  def setup
    @controller = EntrantsController.new
    @request = ActionController::TestRequest.new
    @response = ActionController.TestResponse.new

  end
  
  
  def test_create_originator_and_group
  
    set_time_to_be_1pm

    post :create, :entrant => { :name => "marc rice", :email => "marcr@pokelondon.com", :playing_square_id => 32, :terms => 'agreed', :mobile => '12312312'  }
    assert_redirected_to :controller => :groups, :action => :show
    assert_equal 1, Entrant.find(:all).size
    
  end
  
  def test_cant_create_originator_or_group_without_email
  
    set_time_to_be_1pm
  
    post :create, :entrant => { :name => "marc rice", :playing_square_id => 32, :mobile => '312312', :terms => 'agreed'  }
    assert_redirected_to :controller => :home, :action => :index 
    assert_equal 'Please enter an email address<br>Your email address appears to be invalid<br>', flash[:notice] 

    nothing_gets_created?
    
  end
  
  def test_cant_create_originator_or_group_without_originator_name
  
    set_time_to_be_1pm
  
    post :create, :entrant => { :email => "marc@pokelondon.com", :playing_square_id => 32, :mobile => '312312', :terms => 'agreed'  }
    assert_redirected_to :controller => :home, :action => :index 
    assert_equal 'Please enter a name<br>', flash[:notice] 

    nothing_gets_created?
    
  end
  
  def test_cant_create_originator_or_group_without_originator_square
  
    set_time_to_be_1pm
  
    post :create, :entrant => { :name => "marc rice", :email => "marc@pokelondon.com", :mobile => '23423423', :terms => 'agreed'  }
    assert_redirected_to :controller => :home, :action => :index 
    assert_equal 'Please select a playing square<br>', flash[:notice] 
    
    nothing_gets_created?
    
  end  
  
  def test_cant_create_entrant_when_2pm
  
    set_time_to_be_2pm
  
    post :create, :entrant => { :name => "marc rice", :email => "marc@pokelondon.com", :playing_square_id => 32, :mobile => '243423', :terms => "agreed"  }
    assert_redirected_to :controller => :home, :action => :index 
    assert_equal 'The game is closed between 2pm and 3pm<br>', flash[:notice] 
    
    nothing_gets_created?
    
  end
  
  def test_selecting_a_playing_square
  
    set_time_to_be_1pm
    
    entrant = Entrant.create!(:playing_square_id => 4, :email => "testemail@poke.com")
    entrant.playing_square_id = nil
    entrant.save
    
    get :select_square, :id=>entrant.uid.uid
    assert_select "form" #form is present
    assert_equal nil, flash[:notice]

    post :update_square, :entrant => { :name => "marc rice", :id => entrant.id, :playing_square_id => 34, :terms => "agreed", :mobile => '123123'  }

    assert_equal "Thanks for completing your participation in today's game", flash[:notice]
    assert_equal 1, Entrant.find(:all).size
    assert_equal true, Entrant.find(:first).active
    entrant = Entrant.find(:first)
    assert entrant.playing_square_id
    
  end
  
  def test_selecting_a_playing_square_at_2pm
  
    set_time_to_be_1pm
    
    entrant = Entrant.create!(:playing_square_id => 3, :email => "testemail@poke.com")
    entrant.playing_square_id = nil
    entrant.save
    
    set_time_to_be_2pm
    
    get :select_square, :id=>entrant.uid.uid
    assert_equal nil, flash[:notice]
    post :update_square, :entrant => { :name => "marc rice", :id => entrant.id, :playing_square_id => 34, :terms => "agreed", :mobile => '123123' }
    assert_redirected_to :controller => :entrants, :action => :select_square 
    assert_equal "The game is closed between 2pm and 3pm<br>", flash[:notice]
    assert_equal false, Entrant.find(:first).active  
  
  end
  
  def test_cant_reupdate_playing_square_once_selected
  
    set_time_to_be_1pm 
    entrant = Entrant.create!(:email => "testemail@poke.com", :playing_square_id => 34)
    get :select_square, :id => entrant.uid.uid
    assert_select "form", false
    
    #add test for update
    post :update_square, :entrant => { :name => "marc rice", :id => entrant.id, :playing_square_id => 34, :terms => "agreed", :mobile => '123123'  }
    assert_equal "You have already chosen a square<br>", flash[:notice]
    
    set_time_to_be_1pm 
    entrant = Entrant.create!(:playing_square_id => 35, :email => "testemail2@poke.com")
    entrant.playing_square_id = nil
    entrant.save!
    get :select_square, :id=>entrant.uid.uid
    
    #add update 1
    post :update_square, :entrant => { :name => "marc rice", :id => entrant.id, :playing_square_id => 34, :terms => "agreed", :mobile => '123123' }
    assert_equal "Thanks for completing your participation in today's game", flash[:notice]
    
  
    #update 2 fails
    post :update_square, :entrant => { :name => "marc rice", :id => entrant.id, :playing_square_id => 34, :terms => "agreed", :mobile => '123123'  }    
    assert_equal "You have already chosen a square<br>", flash[:notice]


  end

  
  def test_cant_update_playing_square_once_draw_has_closed_at_2
  
    set_time_to_be_1pm 
    entrant = Entrant.create!(:group_id => 43, :email => "testemail@poke.com")
    set_time_to_be_2pm
    
    get :select_square, :id=>entrant.uid.uid
    #dont show form to update if it already 2pm
    assert_select "form", false
  
    #add test_for_update_method
  
  end
  
  def test_cant_update_playing_square_once_draw_has_been_made_at_3
    
    set_time_to_be_1pm
    entrant = Entrant.create!(:group_id => 43, :email => "testemail@poke.com")
    entrant.playing_square_id = nil
    entrant.save
    
    set_time_to_be_3pm
    #test_cant_update_now
    post :update_square, :entrant => { :name => "marc rice", :id => entrant.id, :playing_square_id => 34, :terms => "agreed", :mobile => '123123'  }
    assert_equal nil, entrant = Entrant.find(entrant.id).name
    assert_redirected_to :controller => :entrants, :action => :select_square 
    assert_equal "You can not complete your entry at this time as the deadline for the draw you were entered into has passed<br>", flash[:notice]
    
  end
  
  def test_cant_update_playing_square_once_draw_has_been_made_at_3_yesterday_and_now_its_3pm
    
    #set time to 3pm yesterday
    set_time_to_be_3pm_yesterday
    entrant = Entrant.create!(:group_id => 43, :email => "testemail@poke.com")
    
    #back to today at 3pm
    new_now = Time.now.tomorrow
    Time.stubs(:now).returns(new_now)
    
    #test_cant_update_now
    post :update_square, :entrant => { :name => "marc rice", :id => entrant.id, :playing_square_id => 34, :group_id => 7, :terms => "agreed", :mobile => '123123'  }
    assert_equal nil, entrant = Entrant.find(entrant.id).name
    assert_redirected_to :controller => :entrants, :action => :select_square 
    assert_equal "You can not complete your entry at this time as the deadline for the draw you were entered into has passed<br>", flash[:notice]
    
  end
  
  def test_cant_update_square_if_no_group_id

    set_time_to_be_1pm
  
    entrant = Entrant.new(:email => "testemail234@poke.com")
    entrant.save
    entrant.group_id = nil
    entrant.save
    post :update_square, :entrant => { :name => "marc rice", :id => entrant.id, :playing_square_id => 24, :terms => "agreed", :mobile => '123123'  }
    assert_equal nil, Entrant.find(entrant.id).playing_square_id
  
  end
  
  def test_terms_is_required_on_create  

    post :create, :entrant => {:name => "marc rice", :playing_square_id => 24, :mobile => '1232312', :email => 'amadasd@asdasd.com'  }
    assert_redirected_to :controller => :home, :action => :index
    assert_equal 'You must accept the terms and conditions<br>', flash[:notice]

  end
  
  def test_mobile_is_required_on_create
  
    post :create, :entrant => {:name => "marc rice", :playing_square_id => 24, :terms => 'agreed', :email => 'amadasd@asdasd.com'   }
    assert_redirected_to :controller => :home, :action => :index 
    assert_equal 'Please enter a mobile number<br>', flash[:notice]
    
  end
  
  def test_terms_is_required_on_update_square 

    entrant = Entrant.create!(:email => "testemail@poke.com", :playing_square_id => 32)
    invitee = Entrant.create!(:group_id => entrant.group.id, :email => 'asdaa@asdsad.com')
    post :update_square, :entrant => {:name => "marc rice", :playing_square_id => 24, :mobile => '1232312', :email => 'amadasd@asdasd.com', :id => invitee.id }
    assert_redirected_to :controller => :entrants, :action => :select_square
    assert_equal 'You must accept the terms and conditions<br>', flash[:notice]

    
    
  end
  
  def test_mobile_is_required_on_update_square
  
    entrant = Entrant.create!(:email => "testemail@poke.com", :playing_square_id => 2)
    invitee = Entrant.create!(:group_id => entrant.group.id, :email => 'asdaa@asdsad.com')
    post :update_square, :entrant => {:name => "marc rice", :playing_square_id => 24, :terms => 'agreed', :email => 'amadasd@asdasd.com', :id => invitee.id   }
    assert_redirected_to :controller => :entrants, :action => :select_square
    assert_equal 'Please enter a mobile number<br>', flash[:notice]
    
  end
  
  def test_optin_and_feed_works
  
    set_time_to_be_1pm
  
    post :create, :entrant => {:name => "marc rice", :playing_square_id => 24, :terms => 'agreed', :email => 'amadasd@asdasd.com', :mobile => '2312312'   }
    e = Entrant.find_by_name('marc rice')
    assert_equal nil, e.optin
    assert_equal nil, e.feed
    
    post :create, :entrant => {:name => "jeff", :playing_square_id => 24, :terms => 'agreed', :email => 'ajmadasd@asdasd.com', :mobile => '2312312', :optin => 1, :feed => 1   }
    assert_equal 2, Entrant.find(:all).size
    e = Entrant.find_by_name("jeff")  
    assert_equal true, e.optin
    assert_equal true, e.feed
    
    
  end

  
  def set_time_to_be_3pm_yesterday



    new_now = Time.now.yesterday.change(:hour => 13)
    Time.stubs(:now).returns(new_now)
  
  end
  
  
  def set_time_to_be_1pm
  
    new_now = Time.now.change(:hour => 13)
    Time.stubs(:now).returns(new_now)
    
  end
  
  def set_time_to_be_2pm
  
    new_now = Time.now.change(:hour => 14)
    Time.stubs(:now).returns(new_now)
    
  end
  
  def set_time_to_be_3pm
  
    new_now = Time.now.change(:hour => 15)
    Time.stubs(:now).returns(new_now)
  
  end
  
  def nothing_gets_created?
  
    assert_equal 0, Entrant.find(:all).size
    assert_equal 0, Group.find(:all).size
    
  end

  
end
