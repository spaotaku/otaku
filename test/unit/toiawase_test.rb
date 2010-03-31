require 'test_helper'

class ToiawaseTest < ActionMailer::TestCase
  test "confirm" do
    @expected.subject = 'Toiawase#confirm'
    @expected.body    = read_fixture('confirm')
    @expected.date    = Time.now

    assert_equal @expected.encoded, Toiawase.create_confirm(@expected.date).encoded
  end

  test "sent" do
    @expected.subject = 'Toiawase#sent'
    @expected.body    = read_fixture('sent')
    @expected.date    = Time.now

    assert_equal @expected.encoded, Toiawase.create_sent(@expected.date).encoded
  end

end
