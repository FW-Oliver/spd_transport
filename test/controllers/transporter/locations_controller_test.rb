require "test_helper"

class Transporter::LocationsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @transporter = User.find_by(role: "transporter")
    sign_in_as(@transporter)
    @location = @transporter.organization.locations.active.first
  end

  test "should get show" do
    get transporter_location_path(@location)
    assert_response :success
  end
end
