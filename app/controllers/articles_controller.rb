class ArticlesController < ApplicationController
  before_action :set_article, only: [:show, :edit, :update, :destroy]

  # GET /articles
  def index
    @articles = signed_in? ? Article.all : Article.publishable
  end

  # GET /articles/1
  def show
    @page_title = @article.title
  end

  # GET /articles/new
  def new
    @article = Article.new
  end

  # GET /articles/1/edit
  def edit
  end

  # POST /articles
  def create
    @article = Article.new(article_params)
    @article.created_by_id = current_user.try(:id)

    if @article.save
      redirect_to @article, notice: t('generic.was_successfully_created', :name => Article.model_name.human)
    else
      render :new
    end
  end

  # PATCH/PUT /articles/1
  def update
    if @article.update(article_params)
      redirect_to @article, notice: t('generic.was_successfully_updated', :name => Article.model_name.human)
    else
      render :edit
    end
  end

  # DELETE /articles/1
  def destroy
    @article.destroy
    redirect_to articles_url, notice: t('generic.was_successfully_destroyed', :name => Article.model_name.human)
  end


  private


  # Use callbacks to share common setup or constraints between actions.
  def set_article
    @article = Article.friendly.find(params[:id])
  end

  # Only allow a trusted parameter "white list" through.
  def article_params
    params.require(:article).permit(:title, :publish, :publish_time, :game_id, :picture_id,
                                    :content, :created_by_id, :updated_by_id, :frontpage)
  end

end

