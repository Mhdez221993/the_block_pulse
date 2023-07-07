require "test_helper"

class CommentTest < ActiveSupport::TestCase
  def setup
    @article = articles(:one)
    @comment = comments(:two)
    @commenter = 'A new commenter'
    @valid_body = "I'm a comment body"
    @valid_status = 'private'
    @bad_status = 'Censored'
    @status_inclusion = 'Status is not included in the list'
  end

  test 'should be valid and creatable with correct attibutes' do
    # new
    comment = Comment.new(
      commenter: @commenter,
      body: @valid_body,
      article: @article,
      status: @valid_status
    )

    assert comment.valid?
    assert comment.save
    comment.reload
    assert_not_nil comment.id
    assert_equal @article.id, comment.article_id
    assert_equal @commenter, comment.commenter
    assert_equal @valid_body, comment.body
    assert_equal @valid_status, comment.status

    # existing
    assert @comment.valid?
  end

  test 'should be invalid with bad status' do
    # new
    article = Article.new(title: @validate_title, body: @validate_body, status: @bad_status)
    assert_not article.valid?
    assert_includes article.errors.full_messages, @status_inclusion

    # existing
    @article.status = @bad_status
    assert_not @article.valid?
    assert_includes @article.errors.full_messages, @status_inclusion
  end
end
