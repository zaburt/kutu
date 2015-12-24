class GameCategoriesController < ApplicationController
  before_action :set_game_category, only: [:show, :edit, :update, :destroy]

  # GET /game_categories
  def index
    @game_categories = GameCategory.all
  end

  # GET /game_categories/1
  def show
  end

  # GET /game_categories/new
  def new
    @game_category = GameCategory.new
  end

  # GET /game_categories/1/edit
  def edit
  end

  # POST /game_categories
  def create
    @game_category = GameCategory.new(game_category_params)

    if @game_category.save
      redirect_to @game_category, notice: 'Game category was successfully created.'
    else
      render :new
    end
  end

  # PATCH/PUT /game_categories/1
  def update
    if @game_category.update(game_category_params)
      redirect_to @game_category, notice: 'Game category was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /game_categories/1
  def destroy
    @game_category.destroy
    redirect_to game_categories_url, notice: 'Game category was successfully destroyed.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_game_category
      @game_category = GameCategory.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def game_category_params
      params.require(:game_category).permit(:name)
    end
end
