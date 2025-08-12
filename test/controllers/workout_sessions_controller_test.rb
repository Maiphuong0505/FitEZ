require "test_helper"

class WorkoutSessionsControllerTest < ActionDispatch::IntegrationTest
  test "should get show" do
    get workout_sessions_show_url
    assert_response :success
  end
end
