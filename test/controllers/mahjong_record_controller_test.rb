require 'test_helper'

class MahjongRecordControllerTest < ActionDispatch::IntegrationTest
  test "should get top" do
    get mahjong_record_top_url
    assert_response :success
  end

end
