require "test_helper"

class ApplicationHelperTest < ActionView::TestCase

  test "select_title method" do
    assert_equal select_title, "catcat"
    assert_equal select_title("マイページ"), "マイページ"
  end
end