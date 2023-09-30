require "test_helper"

class LiveSchedulesControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get live_schedules_index_url
    assert_response :success
  end

  test "should get show" do
    get live_schedules_show_url
    assert_response :success
  end

  test "should get new" do
    get live_schedules_new_url
    assert_response :success
  end

  test "should get create" do
    get live_schedules_create_url
    assert_response :success
  end

  test "should get edit" do
    get live_schedules_edit_url
    assert_response :success
  end

  test "should get update" do
    get live_schedules_update_url
    assert_response :success
  end

  test "should get destroy" do
    get live_schedules_destroy_url
    assert_response :success
  end
end
