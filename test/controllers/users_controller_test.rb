require 'test_helper'

class UsersControllerTest < ActionDispatch::IntegrationTest
  
  def setup
    @user = users(:okinawa)
    @other_user = users(:tokyo)
  end

#new
  test "should get new" do
    get signup_path
    assert_template 'users/new'
  end

#show
  test "should get show when logged in" do
    log_in_as(@user)
    get user_path(@user)
    assert_template 'users/show'
  end

  test "should redirect show when logged in" do
    get user_path(@user)
    assert_not flash.empty?
    assert_redirected_to login_path
  end

#edit
  test "should get edit when logged in" do
    log_in_as(@user)
    get edit_user_path(@user)
    assert_template 'users/edit'
  end

  test "should redirect edit when not logged in" do
    get edit_user_path(@user)
    assert_not flash.empty?
    assert_redirected_to login_path
  end

#update
  test "should patch update" do
    log_in_as(@user)
    patch user_path(@user), params: { user: { name: "沖縄　次郎",
                                              email: "okinawa-jiro@gmail.com"}}
    assert_not flash.empty?
    assert_redirected_to user_path(@user)
    @user.reload
    assert_equal "沖縄　次郎", @user.name
    assert_equal "okinawa-jiro@gmail.com", @user.email
  end

  test "should reidrect update when not logged in" do
    patch user_path(@user), params: { user: { name: '沖縄　花子',
                                              email: @user.email }}
    assert_not flash.empty?
    assert_redirected_to login_path
  end

#destroy
  test "should delete destroy" do
    log_in_as(@user)
    assert_difference "User.count", -1 do
      delete user_path(@user)
    end
    assert_not flash.empty?
    assert_redirected_to root_path
  end

  test "should rediirect destroy when not logged in" do
    delete user_path(@user)
    assert_not flash.empty?
    assert_redirected_to login_path
  end
  
end
