require "test_helper"

class WorkoutPlansControllerTest < ActionDispatch::IntegrationTest
  test "should get create" do
    get workout_plans_create_url
    assert_response :success
  end
end
