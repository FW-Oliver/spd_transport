require "test_helper"

class Admin::InformationPagesControllerTest < ActionDispatch::IntegrationTest
  setup do
    sign_in_as users(:one)
  end

  test "should get index" do
    get admin_information_pages_url
    assert_response :success
  end

  test "should get show" do
    get admin_information_page_url(information_pages(:one))
    assert_response :success
  end

  test "should get new" do
    get new_admin_information_page_url
    assert_response :success
  end

  test "should get edit" do
    get edit_admin_information_page_url(information_pages(:one))
    assert_response :success
  end
end