class BullMailer < ActionMailer::Base
  
  # confirmation email for solo entrants
  def confirm(entrant)
    @subject    = 'thanks for playing'
    @recipients = entrant.email
    @from       = '\"Spot the Bull\" <noreply@spotthebull.co.uk>'
    @sent_on    = Time.now
    @headers    = {}    
    @body['name']    = entrant.name
    @body['uid']        = entrant.uid
    @body['playing_square_id'] = entrant.playing_square_id
  end

  def teammember_confirm(entrant)
    @subject    = 'thanks for playing'
    @recipients = entrant.email
    @from       = '\"Spot the Bull\" <noreply@spotthebull.co.uk>'
    @sent_on    = Time.now
    @headers    = {}    
    @body['name']    = entrant.name
    @body['uid']        = entrant.uid
    @body['playing_square_id'] = entrant.playing_square_id
  end
  
  
  

  # invitations have been sent to your friends
  def initiator(entrant)
    @subject    = 'thanks for playing'
    @recipients = entrant.email
    @from       = '\"Spot the Bull\" <noreply@spotthebull.co.uk>'
    @sent_on    = Time.now
    @headers    = {}    
    @body['name']    = entrant.name
    @body['uid']        = entrant.uid
    @body['playing_square_id'] = entrant.playing_square_id
  end

  # TODO: this setter for friends invite will probably change
  # you've been invitied by a friend
  def invite(friend, originator)
    @subject    = originator.name + ' has invited you to play Spot the Bull'
    @recipients = friend.email
    @from       = '\"Spot the Bull\" <noreply@spotthebull.co.uk>'
    @sent_on    = Time.now
    @headers    = {}    
    @friend     = friend
    @body['name'] = originator.name
    @body['uid'] = friend.uid.uid
  end
  
  # a courtesy email that says a friend has played the game
  def team_confirm(active_member, new_member)
    @subject    = 'a friend’s joined your Spot the Bull team'
    @recipients = active_member.email
    @from       = '\"Spot the Bull\" <noreply@spotthebull.co.uk>'
    @sent_on    = Time.now
    @headers    = {}
    @body['active_member'] = active_member
    @body['new_member'] = new_member
    @body['playing_square_id'] = new_member.playing_square_id
  end

end
