require "test_helper"

class SessionsHelperTest < ActionView::TestCase
 def setup
  @user = users(:michael)
  remember(@user)
 end

 test "verify that the current user is equal to the given user" do
    #Test not passing, false result in second part of current_user session helper
    assert_equal @user, current_user
    assert is_logged_in?
 end

 test "current user returns nil when remember digest is wrong" do
  @user.update_attribute(:remember_digest, User.digest(User.new_token))
  assert_nil current_user
 end

end
