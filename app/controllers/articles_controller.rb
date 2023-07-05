class ArticlesController < ApplicationController
  def index
    @articles = Article.all
  end

  def show
    @article = Article.find(params[:id])
  end

  def create
    @article = Article.new(title: 'Stateless', body: 'Code')

    if @article.save
      redirect_to @article, notice: 'Article was succefully created.'
    else
      render :new, status: :unprocessable_entity
    end
  end
end

# redirect_to '/', status: :unprocessable_entity

# curl -v -X  POST http://127.0.0.1:3000/articles
# skip_before_action :verify_authenticity_token
