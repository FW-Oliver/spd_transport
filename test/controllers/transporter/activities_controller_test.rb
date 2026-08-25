require "test_helper"

class Transporter::ActivitiesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @transporter = User.find_by(role: "transporter")
    sign_in_as(@transporter)
    @location = @transporter.organization.locations.active.first
  end

  test "should create activity without photo when action does not require one" do
    action = @transporter.organization.transporter_actions.find_by(
      name: "Check acceptable number of pans for each clinic"
    )

    assert_difference("TransportActivity.count", 1) do
      post transporter_location_activities_path(@location),
           params: {
             transporter_action_id: action.id
           }
    end

    activity = TransportActivity.order(:created_at).last

    assert_redirected_to transporter_location_path(@location)
    assert_equal @location, activity.location
    assert_equal action, activity.transporter_action
    assert_equal @transporter, activity.user
    assert_equal @transporter.organization, activity.organization
    assert_not_nil activity.performed_at
    assert_not activity.evidence_photo.attached?
    assert_not activity.evidence_thumbnail.attached?
  end

  test "should not create activity without photo when action requires one" do
    action = @transporter.organization.transporter_actions.find_by(
      name: "Pick up soiled instruments"
    )

    assert_no_difference("TransportActivity.count") do
      post transporter_location_activities_path(@location),
           params: {
             transporter_action_id: action.id
           }
    end

    assert_redirected_to transporter_location_path(@location)

    assert_equal(
      "Photo is required for this action",
      flash[:alert]
    )
  end

  test "should create activity with photo when action requires one" do
    action = @transporter.organization.transporter_actions.find_by(
      name: "Pick up soiled instruments"
    )

    photo = fixture_file_upload(
      "test/fixtures/files/test_photo.jpg",
      "image/jpeg"
    )

    assert_difference("TransportActivity.count", 1) do
      post transporter_location_activities_path(@location),
           params: {
             transporter_action_id: action.id,
             photo: photo
           }
    end

    activity = TransportActivity.order(:created_at).last

    assert_redirected_to transporter_location_path(@location)
    assert_equal action, activity.transporter_action
    assert_equal @location, activity.location
    assert_equal @transporter, activity.user
    assert activity.evidence_photo.attached?
    assert activity.evidence_thumbnail.attached?
  end
end