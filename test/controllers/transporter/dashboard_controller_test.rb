require "test_helper"

class Transporter::DashboardControllerTest < ActionDispatch::IntegrationTest
  setup do
    @transporter = User.find_by(role: "transporter")
    sign_in_as(@transporter)
  end

  test "should get index" do
    get transporter_dashboard_path
    assert_response :success
  end
end