require 'test_helper'

class DataControllerTest < ActionController::TestCase
  test "should get enter" do
    get :enter
    assert_response :success
  end

  test "should get search" do
    get :search
    assert_response :success
  end

end
