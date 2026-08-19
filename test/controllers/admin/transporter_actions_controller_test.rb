require "test_helper"

class Admin::TransporterActionsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get admin_transporter_actions_index_url
    assert_response :success
  end

  test "should get new" do
    get admin_transporter_actions_new_url
    assert_response :success
  end

  test "should get edit" do
    get admin_transporter_actions_edit_url
    assert_response :success
  end
end
