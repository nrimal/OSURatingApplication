require 'test_helper'

class RoomPageControllerTest < ActionController::TestCase
  test "should get roomInfo" do
    get :roomInfo
    assert_response :success
  end

end
