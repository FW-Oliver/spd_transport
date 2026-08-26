require "test_helper"

class LocationsControllerTest < ActionDispatch::IntegrationTest
  test "should get show for a valid QR token" do
    location = Location.find_by(active: true)

    get location_path(location.qr_token)

    assert_response :success
  end
end
