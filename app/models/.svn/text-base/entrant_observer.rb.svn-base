class EntrantObserver < ActiveRecord::Observer
    
  def after_create(entrant)
    BullMailer.deliver_confirm(entrant)
  end
end
