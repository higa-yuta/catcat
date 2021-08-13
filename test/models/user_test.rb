require 'test_helper'

class UserTest < ActiveSupport::TestCase
  
  def setup
    @user = users(:okinawa)
  end

  test "Should be valid" do
    assert @user.valid?
  end

  # Presence
  test "Name should be present" do
    @user.name = "  "
    assert_not @user.valid?
  end

  test "Email should be present" do
    @user.email = " "
    assert_not @user.valid?
  end

  test "Password should be present (nonblank)" do
    @user.password = @user.password_confirmation = " " * 6
    assert_not @user.valid?
  end

  # Length
  test "Name shoud be just the right length" do
    @user.name = "a" * 50
    assert @user.valid?
  end
  
  test "Name should not be too long" do
    @user.name = "a" * 51
    assert_not @user.valid?
  end

  test "Email should be just the right length" do
    @user.email = "a" * 181 + "@gmail.com"
    assert @user.valid?
  end

  test "Eamil should not be too long" do
    @user.email = "a" * 182 + "@gmail.com"
    assert_not @user.valid?
  end

  test "Password should be have 6 character" do
    @user.password = @user.password_confirmation = "a" * 6
    assert @user.valid?
  end

  test "Password should be have a minimum length(minimum: 6 character)" do
    @user.password = @user.password_confirmation = 'a' * 5
    assert_not @user.valid?
  end

  # Format
  test "Email validation should accept valid addresses" do
    valid_addresses = %w[user@example.com USER@foo.COM A_US-ER@foo.bar.org
                        first.last@foo.jp alice+bob@baz.cn]
    valid_addresses.each do |address|
      @user.email = address
      assert @user.valid?
    end
  end

  test "Emali validation should reject invalid addresses" do
    invalid_addresses = %w[user@example,com user_at_foo.org user.name@example.
                          foo@bar_baz.com foo@bar+baz.com]
    invalid_addresses.each do |address|
      @user.email = address
      assert_not @user.valid?
    end
  end

  # Uniqueness
  test "email addresses should be unique" do
    dup_user = @user.dup
    @user.save
    assert_not dup_user.valid?
  end

  # CallBack
  test "should be callback when new user saved" do
    @user.email = @user.email.upcase
    @user.save
    assert_equal @user.email, "okinawa@gmail.com"
  end


  test "authenticate? should return false for a user with nil digest" do
    @user.remember_digest = nil
    assert_not @user.authenticate?(@user.remember_token)
  end
end
