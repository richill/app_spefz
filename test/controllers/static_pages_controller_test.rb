require 'test_helper'

class StaticPagesControllerTest < ActionController::TestCase
  test "should get landingpg" do
    get :landingpg
    assert_response :success
  end

end
