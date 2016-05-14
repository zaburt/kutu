class MapController < ApplicationController

  def index
    @fullwidth = true
    @focus_on = params[:focus_on]
    @games = Game.includes(:game_category, :city)
    @game_hash = {}
  end

end

