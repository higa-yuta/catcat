require 'test_helper'

class HomesControllerTest < ActionDispatch::IntegrationTest
  test "should get main" do
    get homes_main_url
    assert_response :success
  end

end
