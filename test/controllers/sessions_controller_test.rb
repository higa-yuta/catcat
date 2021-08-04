require 'test_helper'

class SessionsControllerTest < ActionDispatch::IntegrationTest

  def setup
    @user = users(:okinawa)
  end
  test "should get new" do
    get login_path
    assert_response :success
  end

  # FIXME: fix if when make digest method
  # test "should post create" do
  #   post login_path, params: { session: { email: @user.email, password: 'password' } }
  #   assert_response :success
  # end

  test "should delete destroy" do
    delete logout_path
    assert_response :success
  end

end