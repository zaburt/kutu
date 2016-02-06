class ArticleCategoriesController < ApplicationController
  before_action :set_article_category, only: [:show, :edit, :update, :destroy]

  # GET /article_categories
  def index
    @article_categories = ArticleCategory.all
  end

  # GET /article_categories/1
  def show
  end

  # GET /article_categories/new
  def new
    @article_category = ArticleCategory.new
  end

  # GET /article_categories/1/edit
  def edit
  end

  # POST /article_categories
  def create
    @article_category = ArticleCategory.new(article_category_params)

    if @article_category.save
      redirect_to @article_category, notice: t('generic.was_successfully_created',
                                               :name => ArticleCategory.model_name.human)
    else
      render :new
    end
  end

  # PATCH/PUT /article_categories/1
  def update
    if @article_category.update(article_category_params)
      redirect_to @article_category, notice: t('generic.was_successfully_updated',
                                               :name => ArticleCategory.model_name.human)
    else
      render :edit
    end
  end

  # DELETE /article_categories/1
  def destroy
    @article_category.destroy
    redirect_to article_categories_url, notice: t('generic.was_successfully_destroyed',
                                                  :name => ArticleCategory.model_name.human)
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_article_category
    @article_category = ArticleCategory.find(params[:id])
  end

  # Only allow a trusted parameter "white list" through.
  def article_category_params
    params.require(:article_category).permit(:name)
  end

end

