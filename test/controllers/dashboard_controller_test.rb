require "test_helper"

class DashboardControllerTest < ActionDispatch::IntegrationTest
  test "dashboard route redirects unauthenticated users" do
    get transporter_dashboard_path
    assert_response :redirect
  end
end