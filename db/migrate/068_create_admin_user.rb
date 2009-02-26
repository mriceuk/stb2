class CreateAdminUser < ActiveRecord::Migration
  def self.up
    u = User.new(:login => "knotty", :password => "poke34", :email => "knotty@pokelondon.com", :password_confirmation => "poke34" )
    u.save!
  end

  def self.down
  end
end
