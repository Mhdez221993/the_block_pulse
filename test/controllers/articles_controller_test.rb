require 'test_helper'

class ArticlesControllerTest < ActionDispatch::IntegrationTest
  test 'shuld get index' do
    get articles_url
    assert_response :success
  end
end
