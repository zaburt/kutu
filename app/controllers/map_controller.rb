class MapController < ApplicationController

  def index
    @fullwidth = true
    @focus_on = params[:focus_on]
    @games = Game.include_unpublished(signed_in?).includes(:game_category, :city, :house).order(:name)
  end

end

