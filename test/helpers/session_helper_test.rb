require 'test_helper'

class SessionsHelperTest < ActionView::TestCase

  def setup
    @user = users(:okinawa)
    remember(@user)
  end

  test "current_user returns right user when session is nil" do
    assert_equal current_user, @user
    assert logged_in?
  end

end
