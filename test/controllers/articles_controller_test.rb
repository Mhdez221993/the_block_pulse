require 'test_helper'

class ArticlesControllerTest < ActionDispatch::IntegrationTest
  test 'shuld get index' do
    get articles_url
    assert_response :success
    assert_select 'h1', 'Articles'
    assert_select 'li', Article.count
  end
end
