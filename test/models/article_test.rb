require 'test_helper'

class ArticleTest < ActiveSupport::TestCase
  def setup
    @article = articles(:one)
    @valid_title = "I have a valid tittle #{'z' * 10}"
    @valid_body = "This body is long enough. #{'z' * 2000}"
    @title_blank = "Title can't be blank"
    @body_blank = "Body can't be blank"
    @body_short = 'Body is too short (minimum is 2000 characters)'
    @bad_status = 'Censored'
    @valid_status = 'public'
    @status_inclusion = 'Status is not included in the list'
  end

  test 'should be valid and creatable with correct attributes' do
    # new
    article = Article.new(title: @valid_title, body: @valid_body, status: @valid_status)
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

  test 'should be invalid if body is blank' do
    # new
    article = Article.new(title: @valid_title)
    assert_not article.valid?
    assert_includes article.errors.full_messages, @body_blank

    # existing with empty string
    @article.body = ''
    assert_not @article.valid?
    assert_includes @article.errors.full_messages, @body_blank
  end

  test 'should be invalid id body is too short' do
    too_short = 'Fail'
    # new
    article = Article.new(title: @valid_title, body: too_short)
    assert_not article.valid?
    assert_includes article.errors.full_messages, @body_short

    # existing
    @article.body = too_short
    assert_not @article.valid?
    assert_includes @article.errors.full_messages, @body_short
  end

  test 'should be invalid with bad status' do
    # new
    article = Article.new(title: @validate_title, body: @validate_body, status: @bad_status)
    assert_not article.valid?
    @article.status = @bad_status
    assert_not @article.valid?
    assert_includes @article.errors.full_messages, @status_inclusion
  end

  test 'archived should be true if archived' do
    @article.status = 'archived'
    assert @article.archived?
  end

  test 'archived should be false if not archived' do
    assert_not @article.archived?
    @article.status = 'private'
    assert_not @article.archived?
  end

  test 'public count matches number of public records' do
    assert_equal 1, Article.public_count
  end
end
