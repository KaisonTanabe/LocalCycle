require 'test_helper'

class PhysicalReminderTest < ActionMailer::TestCase
  test "soon" do
    mail = PhysicalReminder.soon
    assert_equal "Soon", mail.subject
    assert_equal ["to@example.org"], mail.to
    assert_equal ["from@example.com"], mail.from
    assert_match "Hi", mail.body.encoded
  end

end
