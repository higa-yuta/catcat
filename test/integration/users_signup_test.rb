require 'test_helper'

class UsersSignupTest < ActionDispatch::IntegrationTest

  test "Routing test" do
    assert_generates '/users/1', { controller: 'users', action: 'show', id: '1'}
  end
  
  test "invalid signup information" do
    get signup_path
    assert_no_difference "User.count" do
      post users_path, params: { user: { name: '',
                                         email: '',
                                         password:              'password',
                                         password_confirmation: 'password'}}
    end
    assert_template 'users/new'
    assert_select "div#error_explantion"
    assert_select "div.alert-error", "3件のエラーがあります。"
    assert_select "li.error_msg", count: 3
    assert_select "li.error_msg", "Name can't be blank"
    assert_select "li.error_msg", "Email can't be blank"
    assert_select "li.error_msg", "Email is invalid"
  end

  test "valid signup New User, redirect to user_path" do
    get signup_path
    user = { name: '名護　太郎', email: 'nago@okinawa.com',
             password: 'okinawa', password_confirmation: 'okinawa'}
    assert_difference "User.count", 1 do
      post users_path, params: { user: user }
    end
    follow_redirect!
    assert_template "users/show"
    assert_select "div.alert-success", "登録することができました"
  end
end
