require "test_helper"

class SinceControllerTest < ActionDispatch::IntegrationTest
  test "should get show" do
    get since_show_url
    assert_response :success
  end
end
