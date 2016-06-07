class GamesController < ApplicationController
  before_action :set_game, only: [:show, :edit, :update, :destroy]

  # GET /games
  def index
    @games = Game.include_unpublished(signed_in?)
    @cities = City.order(:name).pluck(:name)
    @game_categories = GameCategory.order(:name).pluck(:name)
  end

  # GET /games/1
  def show
    @page_title = "#{@game.name} - #{t('games')}"
    @articles = Article.publishable.for_game(@game)
  end

  # GET /games/new
  def new
    @game = Game.new
  end

  # GET /games/1/edit
  def edit
  end

  # POST /games
  def create
    @game = Game.new(game_params)

    if @game.save
      redirect_to @game, notice: t('generic.was_successfully_created', :name => Game.model_name.human)
    else
      render :new
    end
  end

  # PATCH/PUT /games/1
  def update
    if @game.update(game_params)
      redirect_to @game, notice: t('generic.was_successfully_updated', :name => Game.model_name.human)
    else
      render :edit
    end
  end

  # DELETE /games/1
  def destroy
    @game.destroy
    redirect_to games_url, notice: t('generic.was_successfully_destroyed', :name => Game.model_name.human)
  end


  private


  # Use callbacks to share common setup or constraints between actions.
  def set_game
    @game = Game.friendly.find(params[:id])
  end

  # Only allow a trusted parameter "white list" through.
  def game_params
    params.require(:game).permit(:name, :address, :city_id, :game_category_id, :house_id, :phone, :email,
                                 :website, :facebook, :twitter, :instagram, :lat, :lng, :story, :game_times,
                                 :active, :publish, :game_label_ids => [])
  end

end

