require "test_helper"

class Admin::LocationsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @admin = User.find_by(role: "admin")
    sign_in_as(@admin)
  end

  test "should get index" do
    get admin_locations_path
    assert_response :success
  end

  test "should get new" do
    get new_admin_location_path
    assert_response :success
  end

  test "should get edit" do
    location = @admin.organization.locations.first
    get edit_admin_location_path(location)
    assert_response :success
  end
end
