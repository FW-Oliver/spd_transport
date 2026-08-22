require "test_helper"

class Transporter::InformationControllerTest < ActionDispatch::IntegrationTest
  setup do
    sign_in_as users(:two)
  end

  test "should get index" do
    get transporter_information_url
    assert_response :success
  end

  test "should get rules" do
    get transporter_information_rules_url
    assert_response :success
  end

  test "should get access" do
    get transporter_information_access_url
    assert_response :success
  end

  test "should get routes" do
    get transporter_information_routes_url
    assert_response :success
  end
end