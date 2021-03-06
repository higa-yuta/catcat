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

#create
  test "should post create" do
    assert_difference "User.count", 1 do
      post users_path, params: { user: { name: "日本　太郎",
                                      email: "japan@gmail.com",
                                      password: 'password',
                                      password_confirmation: 'password'}}
    end
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

  test "should redirect show when logged in as wrong user" do
    log_in_as(@other_user)
    get user_path(@user)
    assert flash.empty?
    assert_redirected_to root_path
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

  test "should redirect edit when logged in as wrong user" do
    log_in_as(@other_user)
    get edit_user_path(@user)
    assert flash.empty?
    assert_redirected_to root_path
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

  test "should redirect update when logged in as worng user" do
    log_in_as(@other_user)
    patch user_path(@user), params: { user: { name: "沖縄　次郎",
                                              email: "okinawa-jiro@gmail.com"}}
    assert flash.empty?
    assert_redirected_to root_path
  end

  test "should not allow the admin attribute to be edited via the web" do
    log_in_as(@other_user)
    assert_not @other_user.admin?
    patch user_path(@other_user), params: { user: { password: "password",
                                                    password_confirmation: "password",
                                                    admin: true}}
    assert_not @other_user.admin?
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

  test "should redirect destroy when logged in as wrong user" do
    log_in_as(@other_user)
    assert_no_difference "User.count" do
      delete user_path(@user)
    end
    assert flash.empty?
    assert_redirected_to root_path
  end
  
end
