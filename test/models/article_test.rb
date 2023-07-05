require 'test_helper'

class ArticleTest < ActiveSupport::TestCase
  def setup
    @article = articles(:one)
    @valid_title = 'I have a valid tittle'
    @valid_body = 'This body is long enough.'
    @title_blank = "Title can't be blank"
    @body_blanck = "Body can't be blanck"
    @body_short = 'Body is too short (minimun is 10 characters)'
  end

  test 'should be valid and creatable with correct attributes' do
    # new
    article = Article.new(title: @valid_title, body: @valid_body)
    assert article.valid?
    assert article.save
    article.reload
    assert_not_nil article.id
    assert_equal @valid_title, article.title
    assert_equal @valid_body, article.body

    # existing
    assert @article.valid?
  end

  test 'should be invalid if title is blank' do
    # new
    article = Article.new(body: @valid_body)
    assert_not article.valid?
    assert_includes article.errors.full_messages, @title_blank

    # existing with nil
    @article.title = nil
    assert_not @article.valid?
    assert_includes @article.errors.full_messages, @title_blank
  end
end
