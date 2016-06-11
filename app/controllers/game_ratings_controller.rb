class GameRatingsController < ApplicationController

  def index
    @page_title = t('game_ratings')
    @cities = City.order(:name).pluck(:name)
    @game_categories = GameCategory.order(:name).pluck(:name)
    @articles = Article.joins(:game).publishable.has_game.has_rating
  end

end

