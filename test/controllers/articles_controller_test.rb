require 'test_helper'

class ArticlesControllerTest < ActionDispatch::IntegrationTest
  def setup
    @article = articles(:one)
  end

  test 'should get index' do
    get articles_url
    assert_response :success
    assert_select 'h1', 'Articles'
    assert_select 'li', Article.count
  end

  test 'should get show' do
    # get "/articles/#{@article.id}"
    get article_url(@article)
    assert_response :success
    assert_select 'h1', @article.title
    assert_select 'p', @article.body
  end

  test 'shuold get new' do
    get new_article_url(@article)
    assert_response :success
    assert_select 'h1', 'New Article'
    assert_select 'form'
    assert_select 'form div', 3
  end

  test 'should create article' do
    assert_difference('Article.count') do
      post articles_url
    end

    article = Article.last
    assert_redirected_to article_path(article)
    assert_equal 'Stateless', article.title
    assert_equal 'Code', article.body
    assert_equal 'Article was succefully created.', flash[:notice]
  end
end
