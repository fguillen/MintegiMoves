require "test_helper"

class NotifierTest < ActionMailer::TestCase
  def test_admin_user_reset_password
    admin_user = FactoryGirl.create(:admin_user, :email => "reset_password_admin@email.com")
    admin_user.perishable_token = "PERISHABLE-TOKEN"

    email = Notifier.admin_user_reset_password(admin_user).deliver
    assert !ActionMailer::Base.deliveries.empty?

    assert_equal ["mintegi_moves.mail@email.com"], email.from
    assert_equal ["reset_password_admin@email.com"], email.to
    assert_equal "[MintegiMoves] Password reset", email.subject

    # write_fixture("/notifier/admin_user_reset_password.txt", email.body.encoded)

    assert_equal(File.read(fixture("/notifier/admin_user_reset_password.txt")), email.body.encoded)
  end
end
