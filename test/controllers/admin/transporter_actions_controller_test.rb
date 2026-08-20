require "test_helper"

class Admin::TransporterActionsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @admin = User.find_by(role: "admin")
    sign_in_as(@admin)
  end

  test "should get index" do
    get admin_transporter_actions_path
    assert_response :success
  end

  test "should get new" do
    get new_admin_transporter_action_path
    assert_response :success
  end

  test "should get edit" do
    action = @admin.organization.transporter_actions.first
    get edit_admin_transporter_action_path(action)
    assert_response :success
  end
end