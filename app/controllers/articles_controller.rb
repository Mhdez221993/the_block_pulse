class ArticlesController < ApplicationController
  def index
    redirect_to '/', status: :unprocessable_entity
  end
end
