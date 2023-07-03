class ArticlesController < ApplicationController
  def index
    @articles = Article.all
  end
end

# redirect_to '/', status: :unprocessable_entity
