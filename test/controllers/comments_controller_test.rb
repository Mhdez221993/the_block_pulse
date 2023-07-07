require "test_helper"

class CommentsControllerTest < ActionDispatch::IntegrationTest
  def setup
    @article = articles(:one)
    @valid_status = 'private'
  end

  test 'should create a comment' do
    commenter = 'A new commenter'
    body = 'This is my comment on the one article.'
    assert_difference('Comment.count') do
      post article_comments_url(@article), params: {
        comment: {
          commenter: commenter,
          body: body,
          status: @valid_status
        }
      }
    end

    comment = @article.comments.last
    assert_redirected_to article_path(@article)
    assert_equal commenter, comment.commenter
    assert_equal body, comment.body
    assert_equal 'Comment was successfully created.', flash[:notice]
  end
end
