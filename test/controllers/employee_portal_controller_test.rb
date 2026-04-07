require "test_helper"

class EmployeePortalControllerTest < ActionDispatch::IntegrationTest
  test "should get show" do
    get employee_portal_show_url
    assert_response :success
  end
end
