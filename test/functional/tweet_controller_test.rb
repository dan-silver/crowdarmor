require 'test_helper'

class TweetControllerTest < ActionController::TestCase
  test "should get processed" do
    get :processed
    assert_response :success
  end

end
