require 'test_helper'

class SessionsControllerTest < ActionDispatch::IntegrationTest

  def setup
    @user = users(:okinawa)
  end

  test "should get new" do
    get login_path
    assert_response :success
  end

  test "should post create" do
    post login_path, params: { session: { email: @user.email, password: 'password' } }
    assert_response :redirect
  end

  test "should delete destroy" do
    post login_path, params: { session: { email: @user.email, password: 'password' } }
    delete logout_path
    assert_not is_logged_in?
    assert_response :redirect
  end

  test "can't auto-login when user hold worng cookies[:remember_token]" do
    cookies[:remember_token] = User.new_token
    byebug
    assert_not logged_in?
  end

end