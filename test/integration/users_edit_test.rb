require 'test_helper'

class UsersEdtiTest < ActionDispatch::IntegrationTest
  
  def setup
    @user = users(:okinawa)
  end

  test "unsuccessful user's edit" do
    log_in_as(@user)
    get edit_user_path(@user)
    assert_template 'users/edit'
    patch user_path(@user), params: { user: { name: '',
                                              email: 'foo@invalid',
                                              password: 'foo',
                                              password_confirmation: 'bar'} }
    assert_select "div#error_explantion"
    assert_select "div.alert-error", "4件のエラーがあります。"
    assert_select "li.error_msg", "Name can't be blank"
    assert_select "li.error_msg", "Email is invalid"
    assert_select "li.error_msg", "Password confirmation doesn't match Password"
    assert_select "li.error_msg", "Password is too short (minimum is 6 characters)"
  end

  test "successful user's edit" do
    log_in_as(@user)
    get edit_user_path(@user)
    patch user_path(@user), params: { user: { name: "nago",
                                              email: "nago@gmail.com",
                                              password: '',
                                              password_confirmation: ''} }
    @user.reload
    assert_equal @user.name, "nago"
    assert_equal @user.email, "nago@gmail.com"
    assert_not_empty flash
    assert_redirected_to user_path(@user)
  end


  test "successful edit with friendly forwarding" do
    get edit_user_path(@user)
    assert_equal session[:forwarding_url], edit_user_url(@user)
    log_in_as(@user)
    assert_nil session[:forwarding_url]
    assert_redirected_to edit_user_path(@user)
    name = "沖縄　次郎"
    email = "okinawa-jiro@gmail.com"
    patch user_path(@user), params: { user: { name: name,
                                              email: email,
                                              password: '',
                                              password_confirmation: ''} }
    assert_not flash.empty?
    assert_redirected_to user_path(@user)
    @user.reload
    assert_equal @user.name, name
    assert_equal @user.email, email
  end
end
