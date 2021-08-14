require 'test_helper'

class SiteLayoutTest < ActionDispatch::IntegrationTest

  def setup
    @user = users(:okinawa)
  end
  
  test "layout title" do
    log_in_as(@user)
    get root_path
    assert_select "title", "catcat"
    get user_path(@user)
    assert_select "title", "マイページ"
  end
end
