require File.dirname(__FILE__) + '/../test_helper'
require 'mocha'

class EntrantTest < ActiveSupport::TestCase
  # Replace this with your real tests.
  
  #after a user creates a group (and associated entrants) the entrant should be locked into the relevant draw and draw deadline and therefore is unable to select a square if they don't attempt to do so until after the deadline has passed
  def test_cant_update_entrant_after_draw_deadline
    
    #create entrant with date in the past
    e = Entrant.create(:email => "test_user" + rand().to_s + "@test_site.com", :group_id => 3000, :active => 0, :created_at => Time.now.yesterday.yesterday)
    assert !e.update_attributes(:playing_square_id => 34, :active => 1)
    
  end
  
  def test_cant_play_twice_on_one_draw_period
    
    e = Entrant.new(:email => "test_user@test_play_twice.com", :group_id => 3000, :active => 0)
    e.save
    f = Entrant.new(:email => "test_user@test_play_twice.com", :group_id => 3000, :active => 0)
    assert !f.save
#Time.now.change(:min => (Time.now.min-1)

  end
  
  def test_can_play_twice_on_same_day_different_draws

    new_now = Time.now.change(:hour => 11)
    Time.stubs(:now).returns(new_now)
    e = Entrant.new(:email => "test_user2@test_play_twice.com", :group_id => 3000, :active => 1)
    e.save
    
    new_now = Time.now.change(:hour => 15)
    Time.stubs(:now).returns(new_now)
    f = Entrant.new(:email => "test_user2@test_play_twice.com", :group_id => 3001, :active => 1)
    
    assert f.save!
    
  end
  
  #test to show cant update entrant model if draw deadline has passed
  def test_if_created_before_2pm_cant_pick_square_and_become_active_after_2pm_for_todays_draw
    
    time = Time.now.tomorrow.change(:hour => 11)
    Time.stubs(:now).returns(time)

    e = Entrant.new(:email => 'marcr@pokelondon.com')
    e.save!
    
    time = Time.now.change(:hour => 16)
    Time.stubs(:now).returns(time)    
    assert !e.update_attributes(:active => 1)
    
  end
  
  def test_cant_create_entrant_between_2_and_3
    
    time = Time.now.change(:hour => 14)
    Time.stubs(:now).returns(time)
    #TODO: can only test 2 and 3
    e = Entrant.new(:email => 'marcr@pokelondon.com', :created_at => Time.now.change(:hour => 14))
    assert !e.save
    
  end
  
end
