require "test_helper"

class Admin::DashboardControllerTest < ActionDispatch::IntegrationTest
  setup { @user = users(:one) }

  test "should get index" do
    sign_in_as(@user)

    get admin_dashboard_url

    assert_response :success
  end
end