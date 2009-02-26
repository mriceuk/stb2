require File.dirname(__FILE__) + '/../test_helper'

class BullMailerTest < ActionMailer::TestCase
=begin
  tests BullMailer
  def test_confirm
    @expected.subject = 'BullMailer#confirm'
    @expected.body    = read_fixture('confirm')
    @expected.date    = Time.now

    assert_equal @expected.encoded, BullMailer.create_confirm(@expected.date).encoded
  end

  def test_initiator
    @expected.subject = 'BullMailer#initiator'
    @expected.body    = read_fixture('initiator')
    @expected.date    = Time.now

    assert_equal @expected.encoded, BullMailer.create_initiator(@expected.date).encoded
  end

  def test_invite
    @expected.subject = 'BullMailer#invite'
    @expected.body    = read_fixture('invite')
    @expected.date    = Time.now

    assert_equal @expected.encoded, BullMailer.create_invite(@expected.date).encoded
  end

  def test_team_confirm
    @expected.subject = 'BullMailer#team_confirm'
    @expected.body    = read_fixture('team_confirm')
    @expected.date    = Time.now

    assert_equal @expected.encoded, BullMailer.create_team_confirm(@expected.date).encoded
  end
=end
end
