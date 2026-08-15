require "test_helper"

class Transporter::DashboardControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get transporter_dashboard_index_url
    assert_response :success
  end
end
