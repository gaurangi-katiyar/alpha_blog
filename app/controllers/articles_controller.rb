class ArticlesController < ApplicationController

  before_action :set_article, only: [:show, :edit, :update, :destroy]
  before_action :require_user, except: [:show, :index]
  before_action :require_same_user, only: [:edit, :update, :destroy]

  def show
    #@articles = Article.find(params[:id])
  end
  def index
    @articles = Article.paginate(page: params[:page], per_page: 5)
  end
  def new
    @articles = Article.new
  end
  def edit
    #@articles = Article.find(params[:id])
  end
  def create
    #render plain: params[:article]
    @articles = Article.new(article_params)
    #render plain: @articles.inspect
    @articles.user = current_user
    if @articles.save
      flash[:notice] = "Article was created successfully"
      redirect_to @articles
    else
      render 'new'
    end
  end 
  def update
    #@articles = Article.find(params[:id])
    if @articles.update(article_params)
      flash[:notice] = "Article was updated"
      redirect_to @articles
    else
      render 'edit'
    end
  end
  def destroy
    #@articles = Article.find(params[:id])
    @articles.destroy
    redirect_to articles_path
  end

  private
  def set_article
    @articles = Article.find(params[:id])
  end
  def article_params
    params.require(:article).permit(:title, :description, category_ids: [])
  end
  def require_same_user
    if current_user != @articles.user && !current_user.admin?
      flash[:alert] = "You can only edit or delete your own article"
      redirect_to @articles
    end
  end
end