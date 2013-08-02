require 'test_helper'

class CrawlersControllerTest < ActionController::TestCase
  test "should get get_words" do
    get :get_words
    assert_response :success
  end

  test "should get save_db" do
    get :save_db
    assert_response :success
  end

end
