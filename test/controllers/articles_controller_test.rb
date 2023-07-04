require 'test_helper'

class ArticlesControllerTest < ActionDispatch::IntegrationTest
  test 'shuld get index' do
    get articles_url
    assert_response :success
    assert_select 'h1', 'Articles'
    assert_select 'li', Article.count
  end

  test 'shuld get show' do
    @article = articles(:one)
    get article_url(@article)
    assert_response :success
    assert_select 'h1', @article.title
    assert_select 'p', @article.body
  end
end
