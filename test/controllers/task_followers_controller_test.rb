require 'test_helper'

class TaskFollowersControllerTest < ActionDispatch::IntegrationTest
  test "should get create" do
    get task_followers_create_url
    assert_response :success
  end

end
