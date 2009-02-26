require File.dirname(__FILE__) + '/../test_helper'
require 'mocha'

class HomeControllerTest < ActionController::TestCase
  # Replace this with your real tests.
  
  def setup
  
    @controller = HomeController.new
    @request = ActionController::TestRequest.new
    @response = ActionController.TestResponse.new

  end
  
  def test_cant_add_people_at_2pm
    
    #time is 2pm
    new_now = Time.now.change(:hour => 14)
    Time.stubs(:now).returns(new_now)
    
    get :index
    assert_select "h4", "The game is closed between 2pm and 3pm"
    
  end
  
  def test_can_add_people_when_not_2pm
 
    #time is 2pm
    new_now = Time.now.change(:hour => 15)
    Time.stubs(:now).returns(new_now)

    get :index
    assert_select "h4", false
    
    
  end  
    
  
end
