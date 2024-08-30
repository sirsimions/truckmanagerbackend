require "test_helper"

class TrucksControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get trucks_index_url
    assert_response :success
  end

  test "should get filter_options" do
    get trucks_filter_options_url
    assert_response :success
  end
end
