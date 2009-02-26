require File.dirname(__FILE__) + '/../test_helper'
require 'mocha'

class GroupsControllerTest < ActionController::TestCase
  
  def setup
  
    @controller = GroupsController.new
    @request = ActionController::TestRequest.new
    @response = ActionController.TestResponse.new

  end
  
  def set_time_to_be_1pm
  
    new_now = Time.now.change(:hour => 13)
    Time.stubs(:now).returns(new_now)
    
  end


  def test_more_than_3_friends_fails
    
    set_time_to_be_1pm
  
    #simluate creation of originator from entrants::create
    @entrant = Entrant.create!(:active => 1, :email => 'originator_test3isgood@gmail.com', :playing_square_id => 23)
  
    assert_equal 1, @entrant.group.entrants.size
    assert_equal @entrant.group_id, @entrant.group.id

    #post 4, friends
    post :update, :friends => ['test5@asdas.com', 'test6@asdas.com', 'test7@asdsa.com', 'test8@sfasd.com'], :group_id => @entrant.group.id

    assert_redirected_to :controller => :groups, :id => @entrant.group_id
  
    assert_equal 1, @entrant.group.entrants.size
    
    
  end


  def test_3_friends_is_good
    
    set_time_to_be_1pm
    
    #simluate creation of originator from entrants::create
    @entrant = Entrant.create!(:active => 1, :email => 'originator_test3isgood@gmail.com', :playing_square_id => 23, :name => 'amras')

    assert_equal 1, @entrant.group.entrants.size

    #post 3 friends
    post :update, :friends => ['test5@asdas.com', 'test6@asdas.com', 'test7@asdsa.com'], :group_id => @entrant.group.id
    assert_equal 'Congratulations! Your group has been created.', flash[:notice]

    assert_redirected_to :action => :invited
    
    assert_equal 4, @entrant.group.entrants.size

  end
  
  
  def test_cant_resend_friends_invitees_form
  
    set_time_to_be_1pm
  
    #simluate creation of originator from entrants::create
    @entrant = Entrant.create!(:active => 1, :email => 'originator_test3isgood@gmail.com', :playing_square_id => 23, :name => 'asdas')
  
    assert_equal 1, @entrant.group.entrants.size

    #post 3 friends
    post :update, :friends => ['test5@asdas.com', 'test6@asdas.com', 'test7@asdsa.com'], :group_id => @entrant.group.id
    
    assert_redirected_to :action => :invited
    
    post :update, :friends => ['test12@asdas.com', 'test78@asdas.com', 'test32@asdsa.com'], :group_id => @entrant.group.id
  
    assert_redirected_to :controller => :groups, :id => @entrant.group_id
    
    assert_equal 4, @entrant.group.entrants.size
    
  end
  
  def test_gets_nice_error_message_when_inviting_people_to_old_group
    
    #time is yesterday 1pm
    new_now = Time.now.yesterday.change(:hour => 13)
    Time.stubs(:now).returns(new_now)
    
    #simluate creation of originator from entrants::create
    @entrant = Entrant.create!(:active => 1, :email => 'originator_test3isgood@gmail.com', :playing_square_id => 23)
    assert_equal 1, @entrant.group.entrants.size
    
    #change time to 3pm today (thus making previous group invalid)
    new_now = Time.now.tomorrow.change(:hour => 15)
    Time.stubs(:now).returns(new_now)    
    
    #post 3 friends
    post :update, :friends => ['test5@asdas.com', 'test6@asdas.com', 'test7@asdsa.com'], :group_id => @entrant.group.id

    assert_equal @entrant.group.entrants.size, 1
    assert_redirected_to :controller => :groups, :id => @entrant.group_id
    assert_equal 'You can not complete your entry at this time as the deadline for the draw you were entered into has passed<br>', flash[:notice]
    
    
  end
  
  def test_gets_nice_error_message_when_invitee_has_already_entered
   
    set_time_to_be_1pm
    
    #simluate creation of originator from entrants::create
    @entrant = Entrant.create!(:active => 1, :email => 'originator_test3isgood@gmail.com', :playing_square_id => 23)
    assert_equal 1, @entrant.group.entrants.size
    
    #post 3 friends
    post :update, :friends => ['test5@asdas.com', 'test6@asdas.com', 'originator_test3isgood@gmail.com'], :group_id => @entrant.group.id
    
    assert_equal @entrant.group.entrants.size, 1
    assert_redirected_to :controller => :groups, :id => @entrant.group_id
    assert_equal 'originator_test3isgood@gmail.com has already played today!<br>', flash[:notice]
    
  end
  
  def test_cant_invite_people_at_2
  
    set_time_to_be_1pm
  
    #simluate creation of originator from entrants::create
    @entrant = Entrant.create!(:active => 1, :email => 'originator_test3isgood@gmail.com', :playing_square_id => 23, :name => 'amras')
  
    #time is yesterday 2pm
    new_now = Time.now.change(:hour => 14)
    Time.stubs(:now).returns(new_now)

    #post 3 friends
    post :update, :friends => ['test5@asdas.com', 'test6@asdas.com', 'test7@asdsa.com'], :group_id => @entrant.group.id
    assert_equal 'No entrants could be added because the draw deadline has passed.', flash[:notice]
  
    assert_equal 1, @entrant.group.entrants.size
  
  end

  
end
