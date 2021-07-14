class ArticlesController < ApplicationController

  def show
    @article = Article.find(params[:id])
  end
  def index
    @articles = Article.all
  end
  def new
    @articles = Article.new
  end
  def edit
    @articles = Article.find(params[:id])
  end
  def create
    #render plain: params[:article]
    @articles = Article.new(params.require(:article).permit(:title, :description))
    #render plain: @articles.inspect
    if @articles.save
      flash[:notice] = "Article was created successfully"
      redirect_to @articles
    else
      render 'new'
    end
  end 
  def update
    @articles = Article.find(params[:id])
    if @articles.update(params.require(:article).permit(:title, :description))
      flash[:notice] = "Article was updated"
      redirect_to @articles
    else
      render 'edit'
    end
  end
end