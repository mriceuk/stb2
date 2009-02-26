class Group < ActiveRecord::Base

  has_many :entrants
  belongs_to :draw

  validates_presence_of :originator_id, :message => "Could not create a group with this email address. Have you played already today? If so try again tomorrow."

  def after_create
    Entrant.find(self.originator_id).update_attribute("group_id",self.id)
  end
  
end