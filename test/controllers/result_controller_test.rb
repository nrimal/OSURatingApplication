require 'test_helper'

class ResultControllerTest < ActionController::TestCase
  test "should get showResult" do
    get :showResult
    assert_response :success
  end

end
