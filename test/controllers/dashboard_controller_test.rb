require "test_helper"

class DashboardControllerTest < ActionDispatch::IntegrationTest
  test "dashboard route exists" do
    get dashboard_url
    assert_response :redirect
  end
end